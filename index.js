import express from 'express';
import {createProxyMiddleware} from 'http-proxy-middleware';
import dotenv from 'dotenv';

dotenv.config();

const PORT = process.env.PORT || 3000;
const API_URL = process.env.API_URL;

if (!API_URL) {
    console.error('ERROR: API_URL не указан в .env');
    process.exit(1);
}

const app = express();

app.use((req, res, next) => {
    console.log(`${req.method} ${req.originalUrl}`);
    next();
});

app.use(express.json());
app.use(express.urlencoded({extended: true}));

// Прокси для всех /v1/* → API_URL/v1/*
app.use('/v1', createProxyMiddleware({
    target: API_URL, changeOrigin: true, pathRewrite: {'^/v1': '/v1'}, onProxyReq(proxyReq, req) {
        if (req.body && Object.keys(req.body).length) {
            const bodyData = JSON.stringify(req.body);
            proxyReq.setHeader('Content-Type', 'application/json');
            proxyReq.setHeader('Content-Length', Buffer.byteLength(bodyData));
            proxyReq.write(bodyData);
        }
    }, onError(err, req, res) {
        console.error('Proxy error:', err);
        res.status(500).json({error: 'Proxy error', details: err.message});
    }
}));

app.listen(PORT, () => {
    console.log(`🚀 Proxy запущен на http://localhost:${PORT}/v1/...`);
});
