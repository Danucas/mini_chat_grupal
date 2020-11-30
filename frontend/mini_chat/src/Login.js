import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import styles from './Login.module.css';
import ChatRoom from './ChatRoom';

export default class Login extends Component {
	constructor (props) {
		super(props);
		this.rootRef = React.createRef();
	}
	render () {
		return(
			<div ref={ this.rootRef }>
				<form className={ styles.form } autoComplete="off" action="/api-token-auth/" method="post">
					<h1>Member Login</h1>
					<h2 className={ styles.error }></h2>
					<div className={ styles['form-group'] }>
						<input type="text" className={ styles['form-control'] } name="username" id="username" aria-describedby="emailHelp" placeholder="Enter email"></input>
						<small id="emailHelp" className={ [styles['form-text'], styles['text-muted']] }>We'll never share your email with anyone else.</small>
					</div>
					<div className={ styles['form-group'] }>
					<input type="password" className={ styles['form-control'] } name="password" id="password" placeholder="Password"></input>
					</div>
					<div className={ styles['form-group form-check'] }>
						<label className={ styles['form-check-label'] } htmlFor="exampleCheck1">Check me out</label>
						<input type="checkbox" className={ styles['form-check-input'] } id="exampleCheck1"></input>
					</div>
					<button type="submit" className={ styles['btn btn-primary'] }>Submit</button>
					{/* <div className={ styles['link'] }>
						<a href="/login">Forgot password</a>
					</div> */}
					<div className={ styles['link'] }>
						<a href="/register">I don't have an account</a>
					</div>
				</form>
			</div>
		);
	}
	componentDidMount () {
		// console.log(styles.error);
		const root = this.rootRef;
		const inputs = root.current.querySelectorAll('input');
		for (const inp of inputs) {
			inp.addEventListener('input', function () {
				const err = root.current.querySelector(`.${styles.error}`);
				err.innerHTML = '';
			});
		}
		const linkToRegister = root.current.querySelector(`.${styles.link}`);
		linkToRegister.addEventListener('click', function (evn) {
			evn.preventDefault();
			ReactDOM.render(
				<Register></Register>,
				document.getElementById('root')
			)
		});
		root.current.querySelector('form').addEventListener('submit', async function (evn) {
			evn.preventDefault();
			// console.log('request for token');
			const data = new FormData(evn.target);
			const credentials = {};
			for (const key of data.keys()) {
				credentials[key] = data.get(key);
			}
			// console.log(credentials);
			const req = await fetch(
				`${process.env.REACT_APP_API_URL}/api-token-auth/`,
				{
					method: 'POST',
					headers: {
						'Accept': 'application/json',
						'Content-Type': 'application/json',
					},
					body: JSON.stringify(credentials)
				}
			)
			if (req.status === 200) {
				const res = await req.json();
				localStorage.setItem('token', res.token);
				localStorage.setItem('user_id', res.id);
				localStorage.setItem('username', res.username);
				ReactDOM.render(
					<ChatRoom></ChatRoom>,
					document.getElementById('root')
				);
			} else if (req.status === 404) {
				// console.log('Error generating token', await req.json());
				const error = root.current.querySelector(`.${styles.error}`);
				error.innerHTML = 'Wrong user or password';
				evn.target.reset();
			} else {
				// console.log('User or password wrong');
				const error = root.current.querySelector(`.${styles.error}`);
				error.innerHTML = 'Wrong user or password';
				evn.target.reset();
			}
		});
	}
}

export class Register extends Component {
	constructor (props) {
		super(props);
		this.rootRef = React.createRef();
	}
	render () {
		return(
			<div ref={this.rootRef}>
				<form className={ styles.form } autoComplete="off" action="/register/" method="post">
					<h1>Member Register</h1>
					<div className={ styles.['form-group'] }>
					<input type="email" className={ styles['form-control']} name="username" id="username" aria-describedby="emailHelp" placeholder="Enter email"></input>
					<small id="emailHelp" className={ [styles['form-text'], styles['text-muted']]} >We'll never share your email with anyone else.</small>
					</div>
					<h2 className={ styles['error']}></h2>
					<div className={ styles['form-group']}>
					<input type="password" className={ styles['form-control']} name="password" id="password" placeholder="Password"></input>
					</div>
					<div className={ styles['form-group']}>
						<input type="password" className={ styles['form-control']} name="confirm" id="confirm" placeholder="Confirm your Password"></input>
					</div>
					<button type="submit">Submit</button>
					<div className={ styles['link']}>
						<a href="/">I have an account</a>
					</div>
				</form>
			</div>
		);
	}
	componentDidMount () {
		const root = this.rootRef.current;
		root.querySelector('form').style.display = 'block';
		const inputs = root.querySelectorAll('input');
		for (const inp of inputs) {
			inp.addEventListener('input', function () {
				const err = root.querySelector(`.${styles.error}`);
				err.innerHTML = '';
			});
		}
		root.querySelector('form').addEventListener('submit', async function (evn) {
			evn.preventDefault();
			// console.log('request for token');
			const data = new FormData(evn.target);
			const credentials = {};
			for (const key of data.keys()) {
				credentials[key] = data.get(key);
			}
			// console.log(credentials);
			if (credentials.password === credentials.confirm) {
				const req = await fetch(
					`${process.env.REACT_APP_API_URL}/register/`,
					{
						method: 'POST',
						headers: {
							'Accept': 'application/json',
							'Content-Type': 'application/json'
						},
						body: JSON.stringify(credentials)
					}
				)
				if (req.status === 200) {
					const res = await req.json();
					localStorage.setItem('token', res.token);
					localStorage.setItem('user_id', res.id);
					localStorage.setItem('username', res.username);
					ReactDOM.render(
						<ChatRoom></ChatRoom>,
						document.getElementById('root')
					);
				} else {
					const err = document.querySelector(`.${styles.error}`);
					err.innerHTML = 'Please try with another data';
				}
			} else {
				const err = document.querySelector(`.${styles.error}`);
				err.innerHTML = 'The passwords should match';
			}
		});
	}
}