createDb: 
	createdb --username=root --owner=root audacia

 postgres:
	docker run --name root -p 5432:5432 -e POSTGRES_PASSWORD=root -d postgres:14.5

migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/audacia?sslmode=disable" -verbose up

migratedrop:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/audacia?sslmode=disable" -verbose drop

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: createDb postgres migrateup migratedrop test server