package api

import (
	"net/http"
	db "portal-audaciaclan-backend/db/sqlc"

	"github.com/gin-gonic/gin"
)

type createCharacterRequest struct {
	IDUser  int32  `json:"user_id" binding:"required"`
	Name    string `json:"name" binding:"required"`
	ClassID int32  `json:"class_id" binding:"required"`
	Level   int32  `json:"level" binding:"required"`
	Main    bool   `json:"main" binding:"required"`
}

func (server *Server) createCharacter(ctx *gin.Context) {
	var req createCharacterRequest
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	arg := db.CreateCharacterParams{
		IDUser:  req.IDUser,
		Name:    req.Name,
		ClassID: req.ClassID,
		Level:   req.Level,
		Main:    req.Main,
	}

	character, err := server.store.CreateCharacter(ctx, arg)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, character)
}

type updateMainRequest struct {
	IDUser int32 `json:"user_id" binding:"required"`
	Main   bool  `json:"main"`
	ID     int32 `json:"id" binding:"required"`
}

type updateCharacterDTO struct {
	Update        db.Character `json:"update"`
	UpdateGeneral db.Character `json:"updateGeneral"`
}

func (server *Server) updateMain(ctx *gin.Context) {
	var req updateMainRequest
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	var mainUpdateGeneral bool
	if req.Main {
		mainUpdateGeneral = false
	}

	argUpdateGeneral := db.UpdateCharacterParams{
		IDUser: req.IDUser,
		Main:   mainUpdateGeneral,
	}

	updateGeneral, err := server.store.UpdateCharacter(ctx, argUpdateGeneral)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	argUpdate := db.UpdateMainCharacterParams{
		IDUser: req.IDUser,
		Main:   req.Main,
		ID:     req.ID,
	}

	update, err := server.store.UpdateMainCharacter(ctx, argUpdate)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	updateCharacterDTO := updateCharacterDTO{
		Update:        update,
		UpdateGeneral: updateGeneral,
	}

	ctx.JSON(http.StatusOK, updateCharacterDTO)

}
