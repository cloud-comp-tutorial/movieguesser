const express = require("express");
const app = express();
const path = require("path");

app.use(express.json());
app.use(express.static(path.join(__dirname, "/web")));

app.get("*", (_, res) => {
  res.sendFile(path.resolve(__dirname, "/web/index.html"));
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`listening at ${port}`);
});
