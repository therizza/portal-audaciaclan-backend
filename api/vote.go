package api

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
)

type getInformationUserVoteParams struct {
	IDUser int32 `uri:"user_id" binding:"required"`
}

func (server *Server) getInformationUserVote(ctx *gin.Context) {
	var req getInformationUserVoteParams
	err := ctx.ShouldBindUri(&req)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}
	information, err := server.store.GetInformationUserVote(ctx, req.IDUser)
	if err != nil {
		if err == sql.ErrNoRows {
			ctx.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, information)

}
