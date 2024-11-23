const express = require("express");
const axios = require("axios");

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.static('public'));

app.get("/search", async (req, res) => {
  const query  = req.body.query;
  if (!query) {
    return res.status(400).json({ error: "Query not provided" });
  }

  try {
    // Send the request to Ollama
    const response = await axios.post("http://localhost:11434/api/generate", {
      model: "qwen2.5-coder:1.5b", 
      prompt: query,
    });

    // Parse and format the response for better readability
    const rawData = response.data;
    const parsedData = rawData.split("\n").map((entry) => {
      const jsonEntry = JSON.parse(entry);
      if (jsonEntry.done) {
        return jsonEntry.response.trim();
      }
      return jsonEntry.response.trim();
    }).join(" ");

    res.json({ data: parsedData });
  } catch (error) {
    console.error("Error interacting with Ollama:", error.message);
    
    // Add more detailed logging for the error
    if (error.response) {
      // Server responded with a status code outside 2xx range
      console.error("Ollama API responded with error:", error.response.status);
      console.error("Response data:", error.response.data);
    } else if (error.request) {
      // No response received from Ollama
      console.error("No response from Ollama:", error.request);
    } else {
      // Other errors
      console.error("Request error:", error.message);
    }

    res.status(500).json({ error: "Failed to fetch data from Ollama", details: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
