-- name: CreateUser :one
    INSERT INTO users (
        username, 
        email, 
        telephone
    )VALUES (
        $1, $2, $3
    ) RETURNING *;

-- name: AssignStatus :one
    INSERT INTO status_users (
        id_user,
        id_status
    )VALUES (
        $1, $2
    )RETURNING *;

-- name: CreatePassword :one
    INSERT INTO password (
        id_user,
        password
    )VALUES(
        $1, $2
    )RETURNING *;


-- name: GetLoginByEmail :one
    SELECT u.id, u.username, u.email, p.password, su.id_status
	    FROM users u
		    LEFT JOIN password p 
			    ON p.id_user = u.id 
		    LEFT JOIN status_users su 
			    ON su.id_user  = u.id
		WHERE u.email = $1
        LIMIT 1;

-- name: GetUserById :one
    SELECT u.id, u.username, u.email, u.created_ad, u.updated_at, su.id_status, lu.level_id, p.photo 
	    FROM users u
		    LEFT JOIN status_users su 
			    ON su.id_user  = u.id
		    LEFT JOIN photo p 
			    ON p.id_user = u.id 
		    LEFT JOIN level_users lu 
			    ON lu.id_user = u.id 
		WHERE u.id = $1
        LIMIT 1;
