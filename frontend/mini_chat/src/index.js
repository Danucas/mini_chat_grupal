import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import Login from './Login';
import ChatRoom from './ChatRoom';
import reportWebVitals from './reportWebVitals';


if (localStorage.getItem('token')) {
	ReactDOM.render(
		<React.StrictMode>
		  <ChatRoom></ChatRoom>
		</React.StrictMode>,
		document.getElementById('root')
	);
} else {
	ReactDOM.render(
		<React.StrictMode>
		  <Login></Login>
		</React.StrictMode>,
		document.getElementById('root')
	);
}


// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
