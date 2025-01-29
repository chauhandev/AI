import express from 'express';
import axios from 'axios';
const app = express();
app.use(express.json());

app.post('/query', async (req, res) => {
    console.log("request")
    const { prompt } = req.body;
    if (!prompt) {
      return res.status(400).json({ error: 'Prompt is required' });
    }
    console.log("prompt" ,prompt)

    try {
      const response = await axios.post('http://localhost:11434/api/v1/completions', {
        model: 'deepseek-r1:1.5b', // Specify the model here
        prompt,
      });
  
      res.json({ response: response.data });
    } catch (error) {
      console.error('Error querying Ollama:', error.message);
      res.status(500).json({ error: 'Failed to query the model' });
    }
  });
  
  const PORT = 3000;
  app.listen(PORT, () => {
    console.log(`API server is running on http://localhost:${PORT}`);
  });