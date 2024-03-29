// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: user.sql

package db

import (
	"context"
	"database/sql"
	"time"
)

const assignStatus = `-- name: AssignStatus :one
    INSERT INTO status_users (
        id_user,
        id_status
    )VALUES (
        $1, $2
    )RETURNING id, id_user, id_status, created_ad, updated_at
`

type AssignStatusParams struct {
	IDUser   int32 `json:"id_user"`
	IDStatus int32 `json:"id_status"`
}

func (q *Queries) AssignStatus(ctx context.Context, arg AssignStatusParams) (StatusUser, error) {
	row := q.db.QueryRowContext(ctx, assignStatus, arg.IDUser, arg.IDStatus)
	var i StatusUser
	err := row.Scan(
		&i.ID,
		&i.IDUser,
		&i.IDStatus,
		&i.CreatedAd,
		&i.UpdatedAt,
	)
	return i, err
}

const createPassword = `-- name: CreatePassword :one
    INSERT INTO password (
        id_user,
        password
    )VALUES(
        $1, $2
    )RETURNING id, id_user, password, created_ad, updated_at
`

type CreatePasswordParams struct {
	IDUser   int32  `json:"id_user"`
	Password string `json:"password"`
}

func (q *Queries) CreatePassword(ctx context.Context, arg CreatePasswordParams) (Password, error) {
	row := q.db.QueryRowContext(ctx, createPassword, arg.IDUser, arg.Password)
	var i Password
	err := row.Scan(
		&i.ID,
		&i.IDUser,
		&i.Password,
		&i.CreatedAd,
		&i.UpdatedAt,
	)
	return i, err
}

const createUser = `-- name: CreateUser :one
    INSERT INTO users (
        username, 
        email, 
        telephone
    )VALUES (
        $1, $2, $3
    ) RETURNING id, username, email, telephone, created_ad, updated_at
`

type CreateUserParams struct {
	Username  string `json:"username"`
	Email     string `json:"email"`
	Telephone string `json:"telephone"`
}

func (q *Queries) CreateUser(ctx context.Context, arg CreateUserParams) (User, error) {
	row := q.db.QueryRowContext(ctx, createUser, arg.Username, arg.Email, arg.Telephone)
	var i User
	err := row.Scan(
		&i.ID,
		&i.Username,
		&i.Email,
		&i.Telephone,
		&i.CreatedAd,
		&i.UpdatedAt,
	)
	return i, err
}

const getLoginByEmail = `-- name: GetLoginByEmail :one
    SELECT u.id, u.username, u.email, p.password, su.id_status
	    FROM users u
		    LEFT JOIN password p 
			    ON p.id_user = u.id 
		    LEFT JOIN status_users su 
			    ON su.id_user  = u.id
		WHERE u.email = $1
        LIMIT 1
`

type GetLoginByEmailRow struct {
	ID       int32          `json:"id"`
	Username string         `json:"username"`
	Email    string         `json:"email"`
	Password sql.NullString `json:"password"`
	IDStatus sql.NullInt32  `json:"id_status"`
}

func (q *Queries) GetLoginByEmail(ctx context.Context, email string) (GetLoginByEmailRow, error) {
	row := q.db.QueryRowContext(ctx, getLoginByEmail, email)
	var i GetLoginByEmailRow
	err := row.Scan(
		&i.ID,
		&i.Username,
		&i.Email,
		&i.Password,
		&i.IDStatus,
	)
	return i, err
}

const getUserById = `-- name: GetUserById :one
    SELECT u.id, u.username, u.email, u.created_ad, u.updated_at, su.id_status, lu.level_id, p.photo 
	    FROM users u
		    LEFT JOIN status_users su 
			    ON su.id_user  = u.id
		    LEFT JOIN photo p 
			    ON p.id_user = u.id 
		    LEFT JOIN level_users lu 
			    ON lu.id_user = u.id 
		WHERE u.id = $1
        LIMIT 1
`

type GetUserByIdRow struct {
	ID        int32          `json:"id"`
	Username  string         `json:"username"`
	Email     string         `json:"email"`
	CreatedAd time.Time      `json:"created_ad"`
	UpdatedAt time.Time      `json:"updated_at"`
	IDStatus  sql.NullInt32  `json:"id_status"`
	LevelID   sql.NullInt32  `json:"level_id"`
	Photo     sql.NullString `json:"photo"`
}

func (q *Queries) GetUserById(ctx context.Context, id int32) (GetUserByIdRow, error) {
	row := q.db.QueryRowContext(ctx, getUserById, id)
	var i GetUserByIdRow
	err := row.Scan(
		&i.ID,
		&i.Username,
		&i.Email,
		&i.CreatedAd,
		&i.UpdatedAt,
		&i.IDStatus,
		&i.LevelID,
		&i.Photo,
	)
	return i, err
}
