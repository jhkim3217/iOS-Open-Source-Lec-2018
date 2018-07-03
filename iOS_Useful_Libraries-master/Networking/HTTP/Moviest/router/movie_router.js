const express = require('express');
const router = express.Router();
const movies = require('../model/movies');

router.get('/movies', showMovieList);
router.post('/movies', addMovie);

module.exports = router;

function showMovieList(req, res) {
    const movieList = movies.getMovieList();
    const result = { data:movieList, count:movieList.length };
    res.send(result);
}

// 새 영화 추가
// POST 요청 분석 -> 바디 파서
async function addMovie(req, res) {
    const title = req.body.title;

    if (!title) {
        res.status(400).send({error:'title 누락'});
        return;
    }

    const director = req.body.director;
    const year = parseInt(req.body.year);

    try {
        const result = await movies.addMovie(title, director, year);
        res.send({msg:'success', data:result});
    }
    catch ( error ) {
        res.status(500).send(error.msg);
    }
}