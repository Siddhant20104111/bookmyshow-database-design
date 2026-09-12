# BookMyShow - Database Design

## Problem Statement

BookMyShow is a ticketing platform where users can book tickets for movie shows.

For a particular theatre, the system displays the available movies for a selected date along with their show timings, language, and format such as 2D or 3D.

This project focuses on designing a relational database for storing theatre, screen, movie, and show information.

## Entities

1. Theatre
2. Screen
3. Movie
4. Show

## Entity Attributes

### Theatre

| Attribute | Description |
|---|---|
| theatre_id | Unique ID of the theatre |
| theatre_name | Name of the theatre |
| location | Location of the theatre |

### Screen

| Attribute | Description |
|---|---|
| screen_id | Unique ID of the screen |
| theatre_id | ID of the theatre to which the screen belongs |
| screen_name | Name or number of the screen |

### Movie

| Attribute | Description |
|---|---|
| movie_id | Unique ID of the movie |
| movie_name | Name of the movie |
| language | Language of the movie |

### Show

| Attribute | Description |
|---|---|
| show_id | Unique ID of the show |
| screen_id | Screen where the movie is playing |
| movie_id | Movie being played |
| show_date | Date of the show |
| start_time | Starting time of the show |
| end_time | Ending time of the show |
| format | Movie format such as 2D or 3D |

## Relationships

- One Theatre can have multiple Screens.
- One Screen can have multiple Shows.
- One Movie can have multiple Shows.

### Relationship Diagram

```text
Theatre
   |
   | 1 : N
   |
 Screen
   |
   | 1 : N
   |
  Show
   |
   | N : 1
   |
 Movie
```

## Database Design

### THEATRE

- theatre_id (Primary Key)
- theatre_name
- location

### SCREEN

- screen_id (Primary Key)
- theatre_id (Foreign Key)
- screen_name

### MOVIE

- movie_id (Primary Key)
- movie_name
- language

### SHOW

- show_id (Primary Key)
- screen_id (Foreign Key)
- movie_id (Foreign Key)
- show_date
- start_time
- end_time
- format

## Normalization

The database is designed according to the principles of 1NF, 2NF, 3NF, and BCNF.

### 1NF - First Normal Form

Every field contains a single atomic value and there are no repeating groups.

Each show is stored as a separate row in the show table. Multiple show timings are not stored together in a single field.

Therefore, the tables satisfy 1NF.

### 2NF - Second Normal Form

A table is in 2NF when it is in 1NF and there are no partial dependencies.

The tables use single-column primary keys such as theatre_id, screen_id, movie_id, and show_id. Therefore, there are no partial dependencies.

Movie details are stored separately in the movie table instead of being repeated for every show.

Therefore, the tables satisfy 2NF.

### 3NF - Third Normal Form

A table is in 3NF when it is in 2NF and there are no transitive dependencies.

Related information is stored in separate tables.

For example:

```text
Show → Screen → Theatre
```

Theatre details are not unnecessarily stored in the show table. Similarly, movie details are maintained in the movie table.

Therefore, the tables satisfy 3NF.

### BCNF - Boyce-Codd Normal Form

BCNF is a stricter version of 3NF. For every functional dependency, the determinant should be a candidate key.

Examples:

```text
theatre_id → theatre_name, location

screen_id → theatre_id, screen_name

movie_id → movie_name, language

show_id → screen_id, movie_id, show_date, start_time, end_time, format
```

The determinants in these dependencies are keys of their respective tables.

Therefore, the database design satisfies BCNF under the assumptions of this simplified BookMyShow system.

## P1 - SQL Implementation

The `bookmyshow.sql` file contains:

1. Database creation
2. Table creation
3. Primary key and foreign key constraints
4. Sample data insertion
5. Required constraints
6. SQL query for retrieving shows

## P2 - Query

The following query lists all shows available at a given theatre on a given date along with movie name, language, format, and show timings.

```sql
SELECT
    t.theatre_name,
    m.movie_name,
    m.language,
    sh.format,
    sh.show_date,
    sh.start_time,
    sh.end_time
FROM show sh
JOIN screen s
    ON sh.screen_id = s.screen_id
JOIN theatre t
    ON s.theatre_id = t.theatre_id
JOIN movie m
    ON sh.movie_id = m.movie_id
WHERE t.theatre_name = 'PVR: Nexus'
  AND sh.show_date = '2026-09-12'
ORDER BY sh.start_time;
```

## Sample Output

| Theatre | Movie | Language | Format | Date | Start Time | End Time |
|---|---|---|---|---|---|---|
| PVR: Nexus | Dasara | Telugu | 2D | 2026-09-12 | 12:15 | 15:00 |
| PVR: Nexus | Kisi Ka Bhai Kisi Ki Jaan | Hindi | 2D | 2026-09-12 | 13:00 | 16:00 |
| PVR: Nexus | Avatar: The Way of Water | English | 3D | 2026-09-12 | 13:30 | 16:30 |

## Files

```text
bookmyshow-database/
│
├── README.md
└── bookmyshow.sql
```

## Technologies Used

- MySQL
- SQL
- Relational Database Design
- Database Normalization
