const merge = require('webpack-merge');
const convert = require('koa-connect');
const proxy = require('http-proxy-middleware');
const config = require('./webpack.config.js');

const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = merge(config, {
    mode: 'development',
    plugins: [
        new HtmlWebpackPlugin({
            template: 'index.html',
        }),
    ]
});
