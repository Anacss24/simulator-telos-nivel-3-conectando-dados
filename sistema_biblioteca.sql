-- Criação do banco de dados
create database db_biblioteca_telos;

-- Selecionar o banco de dados
use db_biblioteca_telos;

-- Criar tabela de livros
create table books (
	book_id INT primary key auto_increment,
	title VARCHAR(100) not null,
	author VARCHAR(100) not null,
	genre VARCHAR(100) not null,
	published_year INT not null
)

-- Criar tabela de usuários
create table users (
	user_id INT primary key auto_increment,
	name VARCHAR(100) not null,
	email VARCHAR(100) not null
)

-- Criar tabela de empréstimo
create table loans (
	loan_id INT primary key auto_increment,
	book_id INT not null,
	user_id INT not null,
	loan_date DATETIME not null,
	return_date DATETIME,
	foreign key (book_id) references books(book_id),
	foreign key (user_id) references users(user_id)
)

-- Deletar tabela loans
drop table loans;

-- Inserir dados na tabela de livros
INSERT INTO books (title, author, genre, published_year)
VALUES 
('Dom Casmurro', 'Machado de Assis', 'Romance', 1899),
('Grande Sertão: Veredas', 'João Guimarães Rosa', 'Romance', 1956),
('O Alquimista', 'Paulo Coelho', 'Ficção', 1988),
('Memórias Póstumas de Brás Cubas', 'Machado de Assis', 'Romance', 1881),
('Capitães da Areia', 'Jorge Amado', 'Romance', 1937),
('A Hora da Estrela', 'Clarice Lispector', 'Ficção', 1977),
('Ensaio Sobre a Cegueira', 'José Saramago', 'Ficção', 1995),
('O Auto da Compadecida', 'Ariano Suassuna', 'Teatro', 1955),
('Iracema', 'José de Alencar', 'Romance', 1865),
('A Moreninha', 'Joaquim', 'Romance', 1844);

-- Selecionar todos os dados da tabela livros
select * from books;

-- Atualizar informações de livros existentes
update books set author = 'Joaquim Manuel de Macedo' where book_id = 10;


-- Excluir livro do catálogo
delete from books where book_id = 7;


-- Buscar livros no catálogo por título
select * from books where title = 'Dom Casmurro';

-- Buscar livros no catálogo por autor
select * from books where author = 'Machado de Assis';

-- Buscar livros no catálogo por gênero
select title, author from books where genre = 'Romance';

-- Buscar livros no catálogo por título, autor e gênero
select title, author, genre from books;

-- Adicionar novos usuários
insert into users (name, email) values 
('Ana Claudia', 'anaclaudia@gmail.com'),
('Arthur', 'arthur@gmail.com'),
('Victor Hugo', 'victorhugo@gmail.com'),
('Theo', 'theo@gmail.com'),
('Alice', 'alice@gmail.com');

-- Selecionar todos os dados da tabela usuário
select * from users;

-- Atualizar informações de usuários existentes
update users set email = 'alice2024@gmail.com' where user_id = 5;

-- Excluir usuários
delete from users where user_id = 1; 

-- Buscar usuários por nome e email;
select * from users where name = 'Theo';
select * from users where email = 'victorhugo@gmail.com';
select name, email from users where user_id = 4;

-- Registrar empréstimos de livros
insert into loans (book_id, user_id, loan_date) values
(9, 2, '2024-08-03');
(2, 3, '2024-08-30'),
(3, 5,'2024-08-30');

-- Selecionar todos os empréstimos 
select * from loans;

-- Registar devoluções de livros
update loans set return_date = '2024-08-31' where loan_id = 1;

-- Verificar disponibilidade de um livro 
select books.title, users.name, loans.loan_date
from loans
join books on loans.book_id = books.book_id
join users on loans.user_id = users.user_id
where loans.return_date is null;

-- Relatórios de livros emprestados e devolvidos
select books.title, users.name, loans.loan_date, loans.return_date
from loans
join books on loans.book_id = books.book_id
join users on loans.user_id = users.user_id;


-- Verifar usuário com mais empréstomos
select users.name, count(loans.loan_id) as total_loans 
from users join loans on users.user_id = loans.user_id
group by users.user_id
order by total_loans desc limit 1 ;
