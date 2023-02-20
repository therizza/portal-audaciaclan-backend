-- name: CreateStatus :one
    INSERT INTO status (
        name
    )VALUES(
        $1
    )RETURNING *;

-- name: GetStatus :many
    SELECT * FROM status s
        ORDER BY s.id;

-- name: CreateLevel :one
    INSERT INTO level (
        name
    )VALUES(
        $1
    )RETURNING *;

-- name: GetLevel :many 
    SELECT * FROM level l
        ORDER BY id;

-- name: CreateClass :one
    INSERT INTO class (
        name
    )VALUES(
        $1
    )RETURNING *;

-- name: GetClass :many
    SELECT * FROM class c
        ORDER BY c.id;