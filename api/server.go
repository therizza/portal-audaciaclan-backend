package api

import (
	db "portal-audaciaclan-backend/db/sqlc"

	"github.com/gin-gonic/gin"
)

type Server struct {
	store  *db.SQLStore
	router *gin.Engine
}

func NewServer(store *db.SQLStore) *Server {
	server := &Server{store: store}
	router := gin.Default()

	//Bring user data
	router.POST("/user", server.createUser)
	router.GET("/user/id/:id", server.getUserById)
	router.GET("/user/email/:email", server.getUserByEmail)
	router.POST("/user/upload/", server.uploadUser)

	//Bring system data
	router.POST("/system/status/", server.createStatus)
	router.GET("/system/status/", server.getStatus)
	router.POST("/system/level/", server.createLevel)
	router.GET("/system/level/", server.getLevel)
	router.POST("/system/class/", server.createClass)
	router.GET("/system/class/", server.getClass)

	//Bring vote data
	router.GET("/vote/information/:user_id", server.getInformationUserVote)

	//Bring character data
	router.POST("/character/", server.createCharacter)
	router.POST("/character/main/", server.updateMain)

	server.router = router
	return server
}

func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"Api has error: ": err.Error()}
}
