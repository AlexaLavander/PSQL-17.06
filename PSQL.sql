create table if not exists genre(
id SERIAL primary key,
name VARCHAR not NULL
);

create table if not exists singer(
id SERIAL primary key,
nickname VARCHAR not NULL
);

create table if not exists genreSinger(
singerId INTEGER  references singer(id),
genreId INTEGER references genre(id)
);

create table if not exists albumSinger(
albumId SERIAL primary key,
singerId INTEGER  references singer(id)
);


create table if not exists album(
id SERIAL,
name VARCHAR primary key,
year INTEGER
);

create table if not exists song(
id SERIAL primary key,
name VARCHAR,
duration INTEGER,
album VARCHAR references album(name)
);

create table if not exists compilation(
id SERIAL primary key,
name VARCHAR,
year INTEGER
);

create table if not exists compilationSong(
songId INTEGER  references song(id),
compilationId INTEGER  references compilation(id)
);

