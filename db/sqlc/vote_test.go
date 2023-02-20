package db

import (
	"context"
	"database/sql"
	"testing"

	"portal-audaciaclan-backend/util"

	"github.com/stretchr/testify/require"
)

func createRandomInformationUser(t *testing.T) InformationUserVote {
	user := createRandomUser(t)
	arg := InformationUserVoteParams{
		IDUser:         user.ID,
		OldClan:        sql.NullString{String: util.RandomString(10), Valid: true},
		ReasonExit:     sql.NullString{String: util.RandomString(30), Valid: true},
		Friend:         sql.NullString{String: util.RandomString(8), Valid: true},
		PlaySod:        true,
		PlayBc:         true,
		AvailabilityBc: true,
		Description:    sql.NullString{String: util.RandomString(30), Valid: true},
	}

	information, err := testQueries.InformationUserVote(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, information)

	require.Equal(t, arg.IDUser, information.IDUser)
	require.Equal(t, arg.OldClan, information.OldClan)
	require.Equal(t, arg.ReasonExit, information.ReasonExit)
	require.Equal(t, arg.Friend, information.Friend)
	require.Equal(t, arg.PlaySod, information.PlayBc)
	require.Equal(t, arg.AvailabilityBc, information.AvailabilityBc)
	require.Equal(t, arg.Description, information.Description)

	return information
}

func TestInformationUserVote(t *testing.T) {
	createRandomInformationUser(t)
}
