import React, { Component } from 'react';
import ReactDOM, { unmountComponentAtNode } from 'react-dom';
import styles from './ChatRoom.module.css';
let roomId = 'undefined';
let imgB64String = '';

export default class ChatRoom extends Component {
	constructor (props) {
		super(props);
		this.rootRef = React.createRef();
	}
	render () {
		return(
			<div ref={this.rootRef}>
				<div className={ styles.profile }>
					<h2></h2>
					<img></img>
					<button>save pic</button>
				</div>
				<div className={ styles.side_bar }>
					<div className={ styles.profile_pic }>
						<img></img>
						<div className={ styles.change_photo }>
							<input type="file"></input>
						</div>
					</div>
					<div className={ styles.profile_name }>
						<h1>username</h1>
						<input type="text"></input>
					</div>
					<div className={ styles.room_name }>
						<h1></h1>
					</div>
					<div className={ styles.change_room }>
						<h1>change room</h1>
					</div>
					<h2 className={ styles.logout }>Logout</h2>
					<h2 className={ styles.account }>Account</h2>
				</div>
				<div className={ styles.rooms }>
					<h1>Active Rooms</h1>
					<ul>
					</ul>
				</div>
				<div className={ styles.users }>
					<h1>Users</h1>
					<ul>
					</ul>
				</div>

				<div className={ styles.chat }>
					<ul className={ styles.messages }>
					</ul>
					<div className={ styles.uploader }>
						<h2></h2>
						<img></img>
						<button></button>
					</div>
					<div className={ styles.doodle_attribution }>
						<a href="https://www.vecteezy.com/free-vector/pattern" target="_blank">Pattern Vectors by Vecteezy</a>
					</div>
					<div className={ styles.edit_container }>
						<div>
							<input type="file" accept=".png,.jpg"></input>
						</div>
						<textarea name="" cols="30" rows="10" placeholder="Write a new message"></textarea>
						<button></button>
					</div>
				</div>
			</div>
		);
	}
	async componentDidMount () {
		const comp = this;
		const root = comp.rootRef.current;
		console.log(this, comp);
		root.querySelector(`.${styles.profile_name} h1`).innerHTML = localStorage.getItem('username');
		const logout = root.querySelector(`.${styles.logout}`);
		logout.addEventListener('click', function () {
			localStorage.removeItem('token');
			localStorage.removeItem('user_id');
			localStorage.removeItem('username');
			window.location.replace('/');
		});
		const changeRoom = root.querySelector(`.${styles.change_room}`);
		const nameRoom = root.querySelector(`.${styles.room_name}`);
		changeRoom.addEventListener('click', async function () {
			comp.renderRooms(await comp.getRooms());
			root.querySelector(`.${styles.users}`).style.display = 'none';
			root.querySelector(`.${styles.chat}`).style.display = 'none';
			changeRoom.style.display = 'none';
			nameRoom.style.display = 'none';
		});
		comp.setRoomsListeners();
		const editor = root.querySelector(`.${styles.edit_container}`);
		editor.querySelector('button').addEventListener('click', async function () {
			const messageInput = editor.querySelector('textarea');
			console.log(messageInput.value);
			console.log('Send message');
			if (messageInput.value !== '') {
				await comp.sendMessage(messageInput.value);
				messageInput.value = '';
			}
		});
		editor.querySelector('div').addEventListener('click', function (evn) {
			editor.querySelector('input').click();
		});
		editor.querySelector('input').addEventListener('change', function (evn) {
			if (evn.target.files && evn.target.files.length > 0) {
				const file = evn.target.files[0];
				comp.renderImageUploader(file, root.querySelector(`.${styles.uploader} img`));
			}
			evn.target.value = '';
			root.querySelector(`.${styles.uploader}`).style.display = 'block';
		});
		root.querySelector(`.${styles.uploader} h2`).addEventListener('click', function () {
			root.querySelector(`.${styles.uploader }`).style.display = 'none';
		});
		root.querySelector(`.${styles.uploader} button`).addEventListener('click', async function (evn) {
			console.log('upload image');
			await comp.uploadImage('message');
			// console.log(roomId);
			comp.loadMessages();
			root.querySelector(`.${styles.uploader}`).style.display = 'none';
		});
		const profilePic = root.querySelector(`.${styles.profile_pic}`);
		profilePic.addEventListener('mousemove', function () {
			profilePic.querySelector(`.${styles.change_photo}`).style.display = 'block';
		});
		profilePic.addEventListener('mouseleave', function () {
			profilePic.querySelector(`.${styles.change_photo}`).style.display = 'none';
		});
		profilePic.querySelector(`.${styles.change_photo}`).addEventListener('click', function () {
			profilePic.querySelector(`.${styles.change_photo} input`).click();
		});
		profilePic.querySelector(`.${styles.change_photo} input`).addEventListener('change', function (evn) {
			if (evn.target.files && evn.target.files.length > 0) {
				const file = evn.target.files[0];
				comp.renderImageUploader(file, root.querySelector(`.${styles.profile} img`));
			}
			evn.target.value = '';
			root.querySelector(`.${styles.profile}`).style.display = 'block';
		});
		root.querySelector(`.${styles.profile} h2`).addEventListener('click', function () {
			root.querySelector(`.${styles.profile}`).style.display = 'none';
		});
		root.querySelector(`.${styles.profile} button`).addEventListener('click', async function (evn) {
			console.log('uploade image');
			await comp.uploadImage('profile');
			comp.fetchMedia('profile', {
				object: profilePic.querySelector('img'),
				id: 0
			})
			if (roomId !== 'undefined') {
				await comp.getUsers(roomId);
			}
			root.querySelector(`.${styles.profile}`).style.display = 'none';
		});
		comp.fetchMedia('profile', {
			object: profilePic.querySelector('img'),
			id: 0
		});
		const profileName = root.querySelector(`.${styles.profile_name}`);
		profileName.querySelector('h1').addEventListener('click', function (evn) {
			profileName.querySelector('input').style.display = 'block';
			profileName.querySelector('input').value = evn.target.innerHTML;
			profileName.querySelector('input').focus();
		});
		profileName.querySelector('input').addEventListener('keypress', async function (evn) {
			if (evn.keyCode === 13) {
				await comp.saveUsername(evn.target.value)
				console.log('save username: ', evn.target.value);
				evn.target.style.display = 'none';
				profileName.querySelector('h1').innerHTML = evn.target.value;
				if (roomId != 'undefined') {
					await comp.getUsers(roomId);
				}

			}
		});
		profileName.querySelector('input').addEventListener('focusout', async function (evn) {
			evn.target.style.display = 'none';
			profileName.querySelector('h1').innerHTML = evn.target.value;
			await comp.saveUsername(evn.target.value)
		});
		this.renderRooms(await this.getRooms());
		this.setRoomsListeners();
	}
	async getRooms () {
		const comp = this;
		console.log('getRooms');
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/rooms`,
			{
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Authorization': `Token ${localStorage.getItem('token')}`
				}
			}
		);
		if (req.status === 200) {
			const res = await req.json();
			console.log(res);
			return res.rooms;
		} else {
			console.log(req);
			return {};
		}
	}
	setRoomsListeners () {
		const root = this.rootRef.current;
		const comp = this;
		const rooms = root.querySelectorAll(`.${styles.rooms} li`);
		for (const room of rooms) {
			room.addEventListener('click', function (evn) {
				comp.renderRoom(evn.target.getAttribute('room_id'), evn.target.innerHTML);
			});
		}
	}
	async renderRooms (rooms) {
		const root = this.rootRef.current;
		const comp = this;
		console.log(rooms);
		const roomsEl = root.querySelector(`.${styles.rooms}`);
		const ul = roomsEl.querySelector('ul');
		ul.innerHTML = '';
		for (const room of rooms) {
			const li = document.createElement('li');
			li.setAttribute('room_id', room.id);
			li.innerHTML = room.name;
			ul.appendChild(li);
		}
		roomsEl.style.display = 'block';
		comp.setRoomsListeners();
	}
	async renderRoom (id, name) {
		const root = this.rootRef.current;
		roomId = id;
		const changeRoom = root.querySelector(`.${styles.change_room}`);
		changeRoom.style.display = 'block';
		const nameRoom = root.querySelector(`.${styles.room_name}`);
		nameRoom.style.display = 'block';
		console.log('Render room');
		console.log(name)
		root.querySelector(`.${styles.room_name} h1`).innerHTML = name;
		root.querySelector(`.${styles.rooms}`).style.display = 'none';
		console.log(id);
		await this.getUsers(id);	
		root.querySelector(`.${styles.chat}`).style.display = 'block';
		await this.loadMessages();
	}
	async loadMessages () {
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/rooms/${roomId}/messages/all/`,
			{
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Authorization': `Token ${localStorage.getItem('token')}`
				}
			}
		);
		if (req.status === 200) {
			console.log(req.status);
			const res = await req.json();
			this.renderMessages(res.messages, res.id);
			console.log(res);
		} else {
			this.renderMessages([], localStorage.getItem('user_id'));
		}
		
	}
	async getUsers (id) {
		console.log(id);
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/rooms/${id}/users`,
			{
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Authorization': `Token ${localStorage.getItem('token')}`
				}
			}
		);
		const res = await req.json();
		console.log(res);
		this.rootRef.current.querySelector(`.${styles.users}`).style.display = 'block';
		this.renderUsers(res.users);
	}
	renderUsers (users) {
		const root = this.rootRef.current;
		const cont = root.querySelector(`.${styles.users} ul`);
		cont.innerHTML = '';
		for (const user of users) {
			const li = document.createElement('li');
			const time = `${user.last_login.split('T')[1].split('.')[0]}`;
			const date = `${user.last_login.split('T')[0]}`;
			li.innerHTML = `<img><h1>${user.username}</h1><h2>Last login: ${time} / ${date}</h2>`;
			cont.appendChild(li);
			this.fetchMedia('profile', {
				object: li.querySelector('img'),
				id: user.id
			})
		}
	}
	async fetchMedia (type, obj) {
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/media/${obj.id}?type=${type}`,
			{
				method: 'GET',
				headers: {
					'Authorization': `Token ${localStorage.getItem('token')}`
				}
			}
		);
		const res = await req.blob();
		obj.object.src = window.URL.createObjectURL(res);
		// console.log(res);
	}
	async renderMessages (messages, id) {
		const comp = this;
		const root = this.rootRef.current;
		const ul = root.querySelector(`.${styles.messages}`);
		ul.innerHTML = '';
		const first = document.createElement('li');
		first.innerHTML = '<h1>Welcome and Hi!!, start talking with your peers</h1>';
		first.classList.add(styles.first);
		ul.appendChild(first);
		for (const message of messages) {
			const mId = message.id;
			const li = document.createElement('li');
			let menu = '';
			let mine = '';
			let owner = message.user
			if (id === message.user_id) {
				li.classList.add(styles.mine);
				owner = 'me'
				menu = `
						<div option="delete"></div>
						<div menu="message">
							<h1></h1>
							<h2 user_id="${id}">Delete Message</h2>
						</div>`;
				mine = 'mine';
			}
			let media = '';
			if (message.media) {
				media = `<img>`
			}
			const date = new Date(message.created_at).toISOString().split('T')[1].slice(0, 5);
			li.innerHTML = `<div cont="message">
						${menu}
						<h3>${owner}</h3>
						${media}
						<p>${message.content}</p>
						<h4>${date}</h4>
						</div>`;
			if (id === message.user_id) {
				const optionBtn = li.querySelector('[option="delete"]');
				optionBtn.addEventListener('click', function (evn) {
					li.querySelector('[menu="message"]').style.display = 'block';
				});
				const closeBtn = li.querySelector('[menu="message"] h1');
				closeBtn.addEventListener('click', function (evn) {
					li.querySelector('[menu="message"]').style.display = 'none';
				});
				const deleteBtn = li.querySelector('[menu="message"] h2');
				deleteBtn.addEventListener('click', function (evn) {
					const messageId = message.id;
					const conf = window.confirm('Are you sure about deleting this message?');
					if (conf) {
						comp.removeMessage(messageId);
					} else {
						li.querySelector('[menu="message"]').style.display = 'none';
					}
					// li.querySelector('[menu="message"]').style.display = 'none';
				});
			}
			ul.appendChild(li);
			if (message.media) {
				const img = li.querySelector('img');
				const obj = {id: message.id, object: img};
				comp.fetchMedia('message', Object.assign({}, obj));
			}
		}
		setTimeout(function () {
			const lastIndex = ul.querySelectorAll('li').length - 1;
			const lastLi = ul.querySelectorAll('li')[lastIndex];
			ul.scrollTop = ul.scrollHeight;
		}, 200);
	}
	async sendMessage (message) {
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/rooms/${roomId}/messages/`,
			{
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'Authorization': `Token ${localStorage.getItem('token')}`
				},
				body: JSON.stringify({
					content: message
				})
			}
		);
		if (req.status === 200) {
			this.loadMessages();
		}
	}
	async  renderImageUploader (file, img) {
		const readHandler = async function (evn) {
			let data = '';
			let bytes = new Uint8Array(evn.target.result);
			let length = bytes.byteLength;
			for (let i = 0; i < length; i++) {
				data += String.fromCharCode(bytes[i])
			}
			data = window.btoa(data);
			imgB64String = data;
			img.src = `data:image/png;base64,${data}`;
		}
		let r = new FileReader();
		let blob = file.slice(0, file.size);
		r.onload = readHandler;
		r.readAsArrayBuffer(blob);
	}
	async uploadImage (type) {
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/media/`,
			{
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'Authorization': `Token ${localStorage.getItem('token')}`
				},
				body: JSON.stringify({
					data: imgB64String,
					type: type,
					roomId: roomId
				})
			}
		);
		const res = await req.json();
		console.log(res);
		return res;
	}
	async saveUsername (username) {
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/users`,
			{
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json',
					'Authorization': `Token ${localStorage.getItem('token')}`
				},
				body: JSON.stringify({
					'username': username
				})
			}
		);
		// console.log(await req.json());
		if (req.status === 200) {
			const res = await req.json();
		
			console.log(res);
		}
	}
	async removeMessage (messageId) {
		const req = await fetch(
			`${process.env.REACT_APP_API_URL}/messages/${messageId}/`,
			{
				method: 'DELETE',
				headers: {
					'Authorization': `Token ${localStorage.getItem('token')}`
				}
			}
		);
		const res = await req.json();
		console.log(res);
		this.loadMessages();
	}
}
