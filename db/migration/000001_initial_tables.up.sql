CREATE TABLE "settings" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "nome" varchar NOT NULL,
  "vote_analysis_time" int NOT NULL,
  "recruitment_minimum_level" int NOT NULL,
  "recruitment_maximum_level" int NOT NULL,
  "soon" text NOT NULL,
  "recruitment_alert" text NOT NULL,
  "id_level_recruiter" int NOT NULL,
  "id_level_general_configuration" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "users" (
  "id" serial PRIMARY KEY NOT NULL,
  "username" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "telephone" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "password" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "password" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "status" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar UNIQUE NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "status_users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_status" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "blocking_time" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "time" int NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "block" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_blocking_time" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "ranking" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "amount" numeric NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "award" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "award_time" int NOT NULL,
  "id_items" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "winner" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "amount" numeric NOT NULL,
  "id_award" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "score_ranking_users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_type_score" int NOT NULL,
  "id_migration" int NOT NULL,
  "amount" numeric NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_score" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "level" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "level_users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "level_id" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "characters" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "name" varchar UNIQUE NOT NULL,
  "class_id" int NOT NULL,
  "level" int NOT NULL,
  "main" boolean NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "class" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar UNIQUE NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "information_user_vote" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "old_clan" varchar,
  "reason_exit" text,
  "friend" varchar,
  "play_sod" boolean NOT NULL,
  "play_bc" boolean NOT NULL,
  "availability_bc" boolean NOT NULL,
  "description" text,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "vote" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_list_status_vote" int NOT NULL,
  "id_type_vote" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "voting_option" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_vote" int NOT NULL,
  "text" text,
  "photo" text,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "status_vote" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "list_status_vote" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_status_vote" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_vote" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "vow" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_vote" int NOT NULL,
  "id_type_vow" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_vow" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "notifications" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_migration" int NOT NULL,
  "id_user_push" int,
  "id_type_notifications" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_notifications" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "notifications_system" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "integration" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_migration" int NOT NULL,
  "id_user_push" int,
  "id_type_integration" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_integration" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "photo" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "photo" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "category" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "forum" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_category" int NOT NULL,
  "title" text NOT NULL,
  "content" text NOT NULL,
  "id_status_forum" int NOT NULL,
  "id_ban_forum" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "edited_text" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user_edited" int NOT NULL,
  "id_migration" int NOT NULL,
  "content" text NOT NULL,
  "id_type_edited_text" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_edited_text" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "status_forum" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "ban_forum" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "comment" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_forum" int NOT NULL,
  "content" text NOT NULL,
  "id_ban_comment" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "ban_comment" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "signature" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "content" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "shop" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_items_sale" int NOT NULL,
  "value" numeric NOT NULL,
  "content" text NOT NULL,
  "id_type_sale" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "items" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text UNIQUE NOT NULL,
  "level" int NOT NULL,
  "id_type_items" int NOT NULL,
  "description" json NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_items" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "items_sale" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_items" int NOT NULL,
  "description" json NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_sale" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "auction" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_shop" int NOT NULL,
  "closure" timestamptz,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "throw" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_auction" int NOT NULL,
  "id_user" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "party" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_user" int NOT NULL,
  "id_type_party" int NOT NULL,
  "id_leader_party" int NOT NULL,
  "id_map" int NOT NULL,
  "id_sub_server" int NOT NULL,
  "time" timestamptz NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "type_party" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "members" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_party" int NOT NULL,
  "id_characters" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "maps" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "level" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "sub_server" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "pvp" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "boss" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" text NOT NULL,
  "level" int NOT NULL,
  "id_maps" int NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "time_boss" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_boss" int NOT NULL,
  "time" time NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

CREATE TABLE "time_server" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "id_sub_server" int NOT NULL,
  "time" time NOT NULL,
  "created_ad" timestamptz NOT NULL DEFAULT (now ()),
  "updated_at" timestamptz NOT NULL DEFAULT (now ())
);

ALTER TABLE "level_users" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "characters" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "characters" ADD FOREIGN KEY ("class_id") REFERENCES "class" ("id");

ALTER TABLE "password" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "level_users" ADD FOREIGN KEY ("level_id") REFERENCES "level" ("id");

ALTER TABLE "block" ADD FOREIGN KEY ("id_blocking_time") REFERENCES "blocking_time" ("id");

ALTER TABLE "block" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "status_users" ADD FOREIGN KEY ("id_status") REFERENCES "status" ("id");

ALTER TABLE "status_users" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "information_user_vote" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "vote" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "vote" ADD FOREIGN KEY ("id_type_vote") REFERENCES "type_vote" ("id");

ALTER TABLE "vote" ADD FOREIGN KEY ("id_list_status_vote") REFERENCES "list_status_vote" ("id");

ALTER TABLE "list_status_vote" ADD FOREIGN KEY ("id_status_vote") REFERENCES "status_vote" ("id");

ALTER TABLE "vow" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "vow" ADD FOREIGN KEY ("id_vote") REFERENCES "vote" ("id");

ALTER TABLE "vow" ADD FOREIGN KEY ("id_type_vow") REFERENCES "type_vow" ("id");

ALTER TABLE "ranking" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "score_ranking_users" ADD FOREIGN KEY ("id_type_score") REFERENCES "type_score" ("id");

ALTER TABLE "score_ranking_users" ADD FOREIGN KEY ("id") REFERENCES "users" ("id");

ALTER TABLE "voting_option" ADD FOREIGN KEY ("id_vote") REFERENCES "vote" ("id");

ALTER TABLE "notifications" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "notifications" ADD FOREIGN KEY ("id_user_push") REFERENCES "users" ("id");

ALTER TABLE "notifications" ADD FOREIGN KEY ("id_type_notifications") REFERENCES "type_notifications" ("id");

ALTER TABLE "integration" ADD FOREIGN KEY ("id_type_integration") REFERENCES "type_integration" ("id");

ALTER TABLE "integration" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "integration" ADD FOREIGN KEY ("id_user_push") REFERENCES "users" ("id");

ALTER TABLE "photo" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "forum" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "forum" ADD FOREIGN KEY ("id_category") REFERENCES "category" ("id");

ALTER TABLE "forum" ADD FOREIGN KEY ("id_status_forum") REFERENCES "status_forum" ("id");

ALTER TABLE "forum" ADD FOREIGN KEY ("id_ban_forum") REFERENCES "ban_forum" ("id");

ALTER TABLE "comment" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "comment" ADD FOREIGN KEY ("id_forum") REFERENCES "forum" ("id");

ALTER TABLE "comment" ADD FOREIGN KEY ("id_ban_comment") REFERENCES "ban_comment" ("id");

ALTER TABLE "signature" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "edited_text" ADD FOREIGN KEY ("id_user_edited") REFERENCES "users" ("id");

ALTER TABLE "edited_text" ADD FOREIGN KEY ("id_type_edited_text") REFERENCES "type_edited_text" ("id");

ALTER TABLE "settings" ADD FOREIGN KEY ("id_level_recruiter") REFERENCES "level" ("id");

ALTER TABLE "settings" ADD FOREIGN KEY ("id_level_general_configuration") REFERENCES "level" ("id");

ALTER TABLE "shop" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "items" ADD FOREIGN KEY ("id_type_items") REFERENCES "type_items" ("id");

ALTER TABLE "items_sale" ADD FOREIGN KEY ("id_items") REFERENCES "items" ("id");

ALTER TABLE "shop" ADD FOREIGN KEY ("id_items_sale") REFERENCES "items_sale" ("id");

ALTER TABLE "shop" ADD FOREIGN KEY ("id_type_sale") REFERENCES "type_sale" ("id");

ALTER TABLE "auction" ADD FOREIGN KEY ("id_shop") REFERENCES "shop" ("id");

ALTER TABLE "throw" ADD FOREIGN KEY ("id_auction") REFERENCES "auction" ("id");

ALTER TABLE "throw" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "party" ADD FOREIGN KEY ("id_type_party") REFERENCES "type_party" ("id");

ALTER TABLE "party" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");

ALTER TABLE "members" ADD FOREIGN KEY ("id_party") REFERENCES "party" ("id");

ALTER TABLE "members" ADD FOREIGN KEY ("id_characters") REFERENCES "characters" ("id");

ALTER TABLE "party" ADD FOREIGN KEY ("id_leader_party") REFERENCES "members" ("id");

ALTER TABLE "party" ADD FOREIGN KEY ("id_map") REFERENCES "maps" ("id");

ALTER TABLE "party" ADD FOREIGN KEY ("id_sub_server") REFERENCES "sub_server" ("id");

ALTER TABLE "boss" ADD FOREIGN KEY ("id_maps") REFERENCES "maps" ("id");

ALTER TABLE "time_boss" ADD FOREIGN KEY ("id_boss") REFERENCES "boss" ("id");

ALTER TABLE "time_server" ADD FOREIGN KEY ("id_sub_server") REFERENCES "sub_server" ("id");

ALTER TABLE "winner" ADD FOREIGN KEY ("id_award") REFERENCES "award" ("id");

ALTER TABLE "winner" ADD FOREIGN KEY ("id_user") REFERENCES "users" ("id");