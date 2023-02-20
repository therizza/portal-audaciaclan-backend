package api

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
)

type createStatusParams struct {
	Name string `json:"name" binding:"required"`
}

func (server *Server) createStatus(ctx *gin.Context) {
	var req createStatusParams
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	status, err := server.store.CreateStatus(ctx, req.Name)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, status)
}

func (server *Server) getStatus(ctx *gin.Context) {
	status, err := server.store.GetStatus(ctx)
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, status)
}

type createLevelParams struct {
	Name string `json:"name" binding:"required"`
}

func (server *Server) createLevel(ctx *gin.Context) {
	var req createLevelParams
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	level, err := server.store.CreateLevel(ctx, req.Name)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, level)
}

func (server *Server) getLevel(ctx *gin.Context) {
	level, err := server.store.GetLevel(ctx)
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, level)
}

type createClassRequest struct {
	Name string `json:"name" binding:"required"`
}

func (server *Server) createClass(ctx *gin.Context) {
	var req createClassRequest
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	class, err := server.store.CreateClass(ctx, req.Name)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, class)
}

func (server *Server) getClass(ctx *gin.Context) {
	class, err := server.store.GetClass(ctx)
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, class)
}
