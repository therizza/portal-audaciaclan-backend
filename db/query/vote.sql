-- name: InformationUserVote :one
    INSERT INTO information_user_vote (
        id_user,
        old_clan,
        reason_exit,
        friend,
        play_sod,
        play_bc,
        availability_bc,
        description
    )VALUES(
        $1, $2, $3, $4, $5, $6, $7, $8
    )RETURNING *;

-- name: GetInformationUserVote :one
    SELECT * 
        FROM information_user_vote iuv 
        WHERE iuv.id_user = $1
        LIMIT 1;