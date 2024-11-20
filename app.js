const { exec } = require("child_process");

app.get("/search", (req, res) => {
    const query = req.query.query;
    if (!query) {
        return res.status(400).send({ error: "Query parameter is required" });
    }

    exec(`ollama search "${query}"`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${stderr}`);
            return res.status(500).send({ error: "Failed to execute Ollama" });
        }
        res.send({ result: stdout.trim() });
    });
});
