# sqlean.js

This package provides an SQLite database engine compiled for the browser and bundled with [`sqlean`](https://github.com/nalgeon/sqlean) extensions. It's a drop-in replacement for the standard [`sqlite-wasm`](https://sqlite.org/wasm/doc/trunk/npm.md) package.

[Live Demo](https://sqlime.org/)

## Extensions

`sqlean.js` contains 9 essential SQLite extensions:

-   [crypto](https://github.com/nalgeon/sqlean/blob/main/docs/crypto.md): Hashing, encoding and decoding data
-   [define](https://github.com/nalgeon/sqlean/blob/main/docs/define.md): User-defined functions and dynamic SQL
-   [fuzzy](https://github.com/nalgeon/sqlean/blob/main/docs/fuzzy.md): Fuzzy string matching and phonetics
-   [ipaddr](https://github.com/nalgeon/sqlean/blob/main/docs/ipaddr.md): IP address manipulation
-   [math](https://github.com/nalgeon/sqlean/blob/main/docs/math.md): Math functions
-   [regexp](https://github.com/nalgeon/sqlean/blob/main/docs/regexp.md): Regular expressions
-   [stats](https://github.com/nalgeon/sqlean/blob/main/docs/stats.md): Math statistics
-   [text](https://github.com/nalgeon/sqlean/blob/main/docs/text.md): String functions
-   [uuid](https://github.com/nalgeon/sqlean/blob/main/docs/uuid.md): Universally Unique IDentifiers

## Installation

You'll need the SQLite JavaScript API. Include it from CDN or (better) download and host locally:

```html
<script src="https://unpkg.com/@antonz/sqlean/dist/sqlean.js"></script>
```

It's also available as an ECMAScript module:

```js
import sqlite3InitModule from "https://unpkg.com/@antonz/sqlean/dist/sqlean.mjs";
```

You'll also need to download and serve an SQLite WASM file if you're hosting locally:

```
https://unpkg.com/@antonz/sqlean/dist/sqlean.wasm
```

`sqlean.wasm` is used internally by the `sqlean.js` script, so place them in the same folder.

I suggest you host both files locally because they weigh ≈1.5Mb, and CDNs tend to be quite slow with such large files.

You can install them using npm:

```
npm install @antonz/sqlean
```

## Usage

Initialize SQLite:

```js
async function init() {
    const sqlite3 = await sqlite3InitModule({
        print: console.log,
        printErr: console.error,
    });
    const version = sqlite3.capi.sqlite3_libversion();
    console.log(`Loaded SQLite ${version}`);
    return sqlite3;
}
```

Create and query a database:

```js
const SCHEMA = `
create table employees(id, name, salary);
insert into employees values
(1, 'Alice', 120),
(2, 'Bob', 100),
(3, 'Cindy', 80);
`;

init().then((sqlite3) => {
    const db = new sqlite3.oo1.DB();
    db.exec(SCHEMA);

    const sql = "select * from employees";
    let rows = [];
    db.exec({
        sql,
        rowMode: "object",
        resultRows: rows,
    });

    console.log(rows);
});
```

Which prints the following:

```json
[
    {
        "id": 1,
        "name": "Alice",
        "salary": 120
    },
    {
        "id": 2,
        "name": "Bob",
        "salary": 100
    },
    {
        "id": 3,
        "name": "Cindy",
        "salary": 80
    }
]
```

See the [SQLite documentation](https://sqlite.org/wasm) for details.

## License

Copyright 2023+ [Anton Zhiyanov](https://antonz.org/).

The software is available under the MIT License.

## Stay tuned

Follow [**@ohmypy**](https://twitter.com/ohmypy) on Twitter to keep up with new features 🚀
