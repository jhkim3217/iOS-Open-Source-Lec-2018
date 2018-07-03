const fs = require('fs');

class Movie {
    constructor() {
        const data = fs.readFileSync('./model/data.json');
        this.data = JSON.parse(data)
    }

    // Promise 예제
    getMovieList() {
        if (this.data) {
            return this.data;
        }
        else {
            return [];
        }
    }

    addMovie(title, director, year) {
        let newMovie = {title:title, director:director, year:year};
        this.data.push(newMovie);
    }
}

module.exports = new Movie();