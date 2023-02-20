package db

import (
	"context"
	"testing"

	"portal-audaciaclan-backend/util"

	"github.com/stretchr/testify/require"
)

func createRandomUser(t *testing.T) User {
	arg := CreateUserParams{
		Username:  util.RandomString(6),
		Email:     util.RandomEmail(12),
		Telephone: "5511123456789",
	}

	user, err := testQueries.CreateUser(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, user)

	require.Equal(t, arg.Username, user.Username)
	require.Equal(t, arg.Email, user.Email)
	require.Equal(t, arg.Telephone, user.Telephone)

	return user

}

func TestCreateUser(t *testing.T) {
	createRandomUser(t)
}

func createRandomPassword(t *testing.T) Password {
	user := createRandomUser(t)
	arg := CreatePasswordParams{
		IDUser:   user.ID,
		Password: util.RandomString(16),
	}

	password, err := testQueries.CreatePassword(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, password)

	require.Equal(t, arg.IDUser, password.IDUser)
	require.Equal(t, arg.Password, password.Password)

	return password
}

func TestCreatePassword(t *testing.T) {
	createRandomPassword(t)
}

func createRandomStatus(t *testing.T) Status {

	var name string = util.RandomString(6)

	status, err := testQueries.CreateStatus(context.Background(), name)
	require.NoError(t, err)
	require.NotEmpty(t, status)

	require.Equal(t, name, status.Name)

	return status
}

func TestCreateStatus(t *testing.T) {
	createRandomStatus(t)
}

func createRandomStatusUsers(t *testing.T) StatusUser {
	user := createRandomUser(t)
	status := createRandomStatus(t)
	arg := AssignStatusParams{
		IDUser:   user.ID,
		IDStatus: status.ID,
	}

	statusUser, err := testQueries.AssignStatus(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, statusUser)

	require.Equal(t, arg.IDUser, statusUser.IDUser)
	require.Equal(t, arg.IDStatus, statusUser.IDStatus)

	return statusUser

}

func TestCreateStatusUsers(t *testing.T) {
	createRandomStatusUsers(t)
}

func TestGetUserById(t *testing.T) {
	userCreated := createRandomUser(t)

	userValid, err := testQueries.GetUserById(context.Background(), userCreated.ID)
	require.NoError(t, err)
	require.NotEmpty(t, userValid)

	require.Equal(t, userCreated.Username, userValid.Username)
	require.Equal(t, userCreated.Email, userValid.Email)
}

func TestGetLoginByEmail(t *testing.T) {
	userCreated := createRandomPassword(t)

	userValid2, err := testQueries.GetUserById(context.Background(), userCreated.ID)
	require.NoError(t, err)

	userValid, err := testQueries.GetLoginByEmail(context.Background(), userValid2.Email)
	require.NoError(t, err)
	require.NotEmpty(t, userValid)

	require.Equal(t, userValid2.Email, userValid.Email)
	require.NotEmpty(t, userValid.Password)
}
