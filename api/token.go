package api

import (
	"crypto/rand"
	"encoding/base64"
	"time"
)

const (
	tokenExpiration = 15 * time.Minute // Define a duração do tempo de expiração do token como 15 minutos
)

type Token struct {
	UserID    int64     // Armazena a ID do usuário
	Value     string    // Armazena o valor do token gerado
	ExpiresAt time.Time // Armazena o tempo de expiração do token
}

// Função para gerar um novo token
func GenerateToken(userID int64) *Token {
	expiration := time.Now().Add(tokenExpiration)            // Calcula o tempo de expiração do token
	token := make([]byte, 64)                                // Gera um slice de 64 bytes para armazenar o token
	rand.Read(token)                                         // Preenche o slice com números aleatórios
	encodedToken := base64.URLEncoding.EncodeToString(token) // Codifica o token em base64

	return &Token{
		UserID:    userID,
		Value:     encodedToken,
		ExpiresAt: expiration,
	}
}

// Função para verificar se um token ainda é válido
func IsTokenValid(token *Token) bool {
	return time.Now().Before(token.ExpiresAt) // Retorna true se o tempo atual ainda está antes do tempo de expiração do token
}
