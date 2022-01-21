const mysql = require('mysql');

const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "instawash"
});

con.connect(function (err) {
  if (err) throw err;
});

const createMessage = ({ conversationId, author, message, isFile }, callback) => {
  const date = new Date();
  con.query('insert into messages (`conversationId`, `message`, `isFile`, `author`, `timestamp`) values("' + conversationId + '", "' + message + '", "' + isFile + '", "' + author + '", "' + date.getTime() + '");', function (err, rows, fields) {
    if (err) throw err;
    if (rows.insertId >= 0) callback(true)
    else callback(false);
  });
};

const getMessages = ({ conversationId }, callback) => {
  con.query('SELECT * from messages where conversationId = "' + conversationId + '";', function (err, rows) {
    if (err) throw err;
    if (rows && rows.length > 0) callback(rows);
    else callback([]);
  });
};

module.exports = { createMessage, getMessages };