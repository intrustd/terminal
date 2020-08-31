const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const devMode = process.env.NODE_ENV !== 'production';

module.exports = {
    entry: './app.js',
    output: {
        path: __dirname + '/dist',
        filename: devMode ? '[name].js' : '[name].[hash].js',
    },
    module: {
        rules: [
            {
                test: /\.ts$/,
                enforce: 'pre',
                use: 'tslint-loader',
            },
            {
                test: /\.tsx?$/,
                use: 'ts-loader',
                exclude: /node_modules/
            },
            {
                test: /\.js$/,
                exclude: /node_modules\/(?!zmodem.js\/)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['env']
                    }
                },
            },
            {
                test: /\.s?[ac]ss$/,
                use: [
                    devMode ? 'style-loader' : MiniCssExtractPlugin.loader,
                    'css-loader',
                    'sass-loader',
                ],
            },
        ]
    },
    resolve: {
        extensions: [ '.tsx', '.ts', '.js' ],
    },
    plugins: [
        new CopyWebpackPlugin([
            { from: 'favicon.png', to: '.' }
        ], {}),
        new MiniCssExtractPlugin({
            filename: devMode ? '[name].css' : '[name].[hash].css',
            chunkFilename: devMode ? '[id].css' : '[id].[hash].css',
        })
    ],
    performance : {
        hints : false
    },
    devtool: devMode ? 'cheap-module-eval-source-map' : 'source-map',
}
