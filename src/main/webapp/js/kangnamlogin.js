const router = require('express').Router();
const path = require('path'); // 동적 경로를 사용할 때 유용합니다.

router.post('/login', (req, res) => {
    const mysql = require('../database')();
    const connection = mysql.init();
    mysql.db_open(connection);
    
    const userid = req.body.id;
    const userpw = req.body.pw;

    connection.query('SELECT * FROM USERS WHERE id = ? AND pw = ? ', [userid, userpw], (err, results, fields) => {
        if (err) {
            throw err;
        } else if (results.length > 0) {
            // 로그인 성공 시, 메인 페이지로 리디렉션
            const mainPagePath = path.join(__dirname, '..', 'views', 'MainPage.jsp'); 
            res.send('<script type="text/javascript">alert("환영합니다!"); location.href = "' + mainPagePath + '";</script>');
        } else {
            // 로그인 실패 시, 로그인 페이지로 리디렉션
            const loginPagePath = path.join(__dirname, '..', 'views', 'Login.jsp'); 
            res.send('<script>alert("로그인 정보가 일치하지 않습니다."); document.location.href="' + loginPagePath + '";</script>');
        }
        connection.end(); // DB 연결 끊기
    });
});

module.exports = router;
