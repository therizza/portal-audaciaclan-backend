package api

import (
	"bytes"
	"crypto/sha512"
	"database/sql"
	"mime"
	"mime/multipart"
	"net/http"
	"path/filepath"
	db "portal-audaciaclan-backend/db/sqlc"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type createUserRequest struct {
	Name           string         `json:"name" binding:"required"`
	Email          string         `json:"email" binding:"required"`
	Telephone      string         `json:"telephone" binding:"required"`
	Password       string         `json:"password" binding:"required"`
	OldClan        sql.NullString `json:"old_clan"`
	ReasonExit     sql.NullString `json:"reason_exit"`
	Friend         sql.NullString `json:"friend"`
	PlaySod        bool           `json:"play_sod"`
	PlayBc         bool           `json:"play_bc"`
	AvailabilityBc bool           `json:"availability_bc"`
	Description    sql.NullString `json:"description"`
	Nick           string         `json:"nick" binding:"required"`
	ClassID        int32          `json:"class_id" binding:"required"`
	Level          int32          `json:"level" binding:"required"`
	Main           bool           `json:"main" binding:"required"`
}

// DTO Join data for create user response
type createUserDTO struct {
	User        db.User                `json:"user"`
	Password    db.Password            `json:"password"`
	Status      db.StatusUser          `json:"status"`
	Information db.InformationUserVote `json:"information"`
	Character   db.Character           `json:"character"`
}

// Function CreateUser
func (server *Server) createUser(ctx *gin.Context) {
	var req createUserRequest
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	argUser := db.CreateUserParams{
		Username:  req.Name,
		Email:     req.Email,
		Telephone: req.Telephone,
	}

	//sending user
	user, err := server.store.CreateUser(ctx, argUser)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	//crypt the password with bcrypt
	hashedInput := sha512.Sum512_256([]byte(req.Password))
	trimmedHash := bytes.Trim(hashedInput[:], "\x00")
	preparedPassword := string(trimmedHash)
	passwordHashInBytes, err := bcrypt.GenerateFromPassword([]byte(preparedPassword), bcrypt.DefaultCost)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
	}
	var passwordHashed = string(passwordHashInBytes)

	argPassword := db.CreatePasswordParams{
		IDUser:   user.ID,
		Password: passwordHashed,
	}

	//sending password
	password, err := server.store.CreatePassword(ctx, argPassword)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	//hard code STATUS = 1 PENDING
	argStatus := db.AssignStatusParams{
		IDUser:   user.ID,
		IDStatus: 1,
	}

	//sending status
	status, err := server.store.AssignStatus(ctx, argStatus)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	argInformation := db.InformationUserVoteParams{
		IDUser:         user.ID,
		OldClan:        req.OldClan,
		ReasonExit:     req.ReasonExit,
		Friend:         req.Friend,
		PlaySod:        req.PlaySod,
		PlayBc:         req.PlayBc,
		AvailabilityBc: req.AvailabilityBc,
		Description:    req.Description,
	}

	//sending information
	information, err := server.store.InformationUserVote(ctx, argInformation)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	argCharacter := db.CreateCharacterParams{
		IDUser:  user.ID,
		Name:    req.Nick,
		ClassID: req.ClassID,
		Level:   req.Level,
		Main:    req.Main,
	}

	//sending Character
	character, err := server.store.CreateCharacter(ctx, argCharacter)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	//DTO return createUser
	createUserDTO := createUserDTO{
		User:        user,
		Password:    password,
		Status:      status,
		Information: information,
		Character:   character,
	}

	ctx.JSON(http.StatusOK, createUserDTO)

}

type getUserByIdRequest struct {
	ID int32 `uri:"id" binding:"required"`
}

func (server *Server) getUserById(ctx *gin.Context) {
	var req getUserByIdRequest

	err := ctx.ShouldBindUri(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
	}

	user, err := server.store.GetUserById(ctx, req.ID)
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, user)
}

type getLoginByEmailRequest struct {
	Email string `uri:"email" binding:"required"`
}

func (server *Server) getUserByEmail(ctx *gin.Context) {
	var req getLoginByEmailRequest
	err := ctx.ShouldBindUri(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	user, err := server.store.GetLoginByEmail(ctx, req.Email)
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, user)
}

type postUserPhoto struct {
	ID    int                   `form:"id" binding:"required"`
	Image *multipart.FileHeader `form:"image" binding:"required"`
}

func (server *Server) uploadUser(c *gin.Context) {
	var req postUserPhoto

	err := c.ShouldBind(&req)
	if err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	// Extrai o arquivo da estrutura
	file := req.Image

	// Verifica se o arquivo é uma imagem
	ext := filepath.Ext(file.Filename)
	if ext == "" || !strings.HasPrefix(mime.TypeByExtension(ext), "image/") {
		c.JSON(http.StatusBadRequest, gin.H{"error": "O arquivo deve ser uma imagem"})
		return
	}

	// Verifica o tamanho do arquivo (3 MB = 3 * 1024 * 1024 bytes)
	if file.Size > 3*1024*1024 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "O tamanho da imagem deve ser de até 3 MB"})
		return
	}

	// Gera um nome único para o arquivo
	uuidFilename := uuid.New().String() + ext

	// Salva o arquivo no servidor
	if err := c.SaveUploadedFile(file, "upload/"+uuidFilename); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
}
