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
id SERIAL primary key references albumSinger(albumId),
name VARCHAR,
year INTEGER
);

create table if not exists song(
id SERIAL primary key,
name VARCHAR,
duration Integer,
album SERIAL references album(id)
);

create table if not exists compilation(
id SERIAL primary key,
name VARCHAR(100),
year INTEGER
);

create table if not exists compilationSong(
songId INTEGER  references song(id),
compilationId INTEGER  references compilation(id)
);



insert into genre values(1,'Rok&Roll');
insert into genre values(2, 'Punk');
insert into genre values(3, 'Rap');

insert into singer values(1, 'Kurt Cobain');
insert into singer values(2,'The Clash');
insert into singer values(3, 'Alyona Shwetz');
insert into singer values(4, 'Eminem');

insert into albumSinger values(1, 1);
insert into albumSinger values(2, 2);
insert into albumSinger values(3, 3);
insert into albumSinger values(5, 4);
insert into albumSinger values(4, 4);


insert into album values(1, 'Nevermind', 1991);
insert into album values(2, 'Having words', 1990);
insert into album values(3, 'The First Date', 2020);
insert into album values(4, 'Godzila', 2005);
insert into album values(5, 'Party Hits', 2009);


insert into song values(1, 'It smells like teen spirit', 5.00*60, 1);
insert into song values(2, 'Come as you are', 3.38*60, 1);
insert into song values(3, 'Saving sid', 1.00*60, 2);
insert into song values(4, 'Люби', 3.07*60, 3);
insert into song values(5, 'Godzila', 4.10*60, 4);
insert into song values(6, 'Smack That', 4.00*60, 5);


insert into compilation values(1, 'Alternate nineteens', '2019');
insert into compilation values(2, 'Come As You Are', '2019');
insert into compilation values(3, 'FANAT', '2020');
insert into compilation values(4, 'Party Hits', '2020');
insert into compilation values(5, 'Sandinista', '1980');
insert into compilation values(6, 'Discover more Hip Hop', '1980');


insert into genresinger values(1, 1);
insert into genresinger values(2, 2);
insert into genresinger values(3, 2);
insert into genresinger values(4, 3);



insert into compilationSong values(1, 1);
insert into compilationSong values(2, 2);
insert into compilationSong values(3, 5);
insert into compilationSong values(4, 3);
insert into compilationSong values(5, 6);
insert into compilationSong values(6, 4);


select duration, name from song
where (duration = (select max(duration) from song))


select name from song
where song.duration >= 3.5*60

select name from compilation 
where year>=2018 and not (year>2020);

select nickname from singer
where nickname not like '% %';

select name from song
where (name like '% my %') or (name like '% мой %')
or (name like '%my %') or (name like '%мой %')
or (name like '% my%') or (name like '% мой%')
or (name like 'my') or (name like 'мой')
;

select genre.name, count(*) as amount FROM genre
join genresinger on genre.id = genresinger.genreid 
group by genre.name
;

select count(song) as amount from album
inner join song on album.id = song.album 
WHERE album.year BETWEEN 2019 and 2020
;

select album.name, avg(song.duration) as duration from album
inner join song on album.id = song.album 
group by album.name;

select singer.nickname  from singer
where singer.nickname not in 
(select singer.nickname  from singer 
inner join albumsinger on albumsinger.singerid = singer.id
inner join album on album.id = albumsinger.albumid 
where album.year = 2020)
;

select compilation.name from compilation
join compilationsong on compilation.id = compilationsong.compilationid 
join song on compilationsong.songid = song.id 
join album on album.id = song.album 
join albumsinger on albumsinger.albumid = album.id 
join singer on albumsinger.singerid = singer.id 
where singer.nickname  = 'Kurt Cobain';