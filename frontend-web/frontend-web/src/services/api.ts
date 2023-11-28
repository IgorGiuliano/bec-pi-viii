import axios from 'axios';

const api = axios.create({
    baseURL: 'https://api-robotinic.onrender.com/'
});

export default api;
