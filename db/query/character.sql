-- name: CreateCharacter :one
    INSERT INTO "characters" (
        id_user,
        "name",
        class_id, 
        "level",
        main
    )VALUES(
        $1, $2, $3, $4, $5
    )RETURNING *;

-- name: UpdateMainCharacter :one
    update "characters" 
        set 
            main = $2, 
            updated_at = NOW () 
        where id_user = $1
            and id = $3
            RETURNING *;

-- name: UpdateCharacter :one
    update "characters"
        set
            main = $2,
            updated_at = NOW ()
        where id_user = $1
        RETURNING *; 

-- name: GetMainCharacter :one
    SELECT * 
        FROM "characters"
        WHERE id_user = $1
            and main = $2
        LIMIT 1;

