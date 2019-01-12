import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import 'open-iconic/font/css/open-iconic-bootstrap.min.css';
import '../dist/css/AppLogin.css';
import React from 'react';
import API from './Api';


export default class AppLogin extends React.Component {
  constructor(props) {
    super(props);
    this.state = { name: '', err: '' };
  }

  handleChange(event) {
    this.setState({ name: event.target.value });
  }

  handleSubmit() {
    const user = {
      username: this.state.name,
    };

    API.post('/auth', user)
      .then(() => this.props.history.push(`/home/${user.username}`))
      .catch(error => this.setState({ err: error }));
  }

  handleError() {
    let error = '';
    if (this.state.err) {
      const msg = 'Ha ocurrido un error. Código de error: ';
      error = (
        <div className="alert alert-danger alert-dismissible fade show" role="alert">
          {msg}{this.state.err.response.status}. {this.state.err.response.data.message}.
          <button type="button" className="close" data-dismiss="alert" aria-label="Close" onClick={() => this.setState({ err: '' })}>
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      );
    }
    return (error);
  }

  render() {
    return (
      <div className="container" id="containerAppLogin">
        {this.handleError()}

        <div className="alert alert-primary" id="tituloAppLogin">
          <h3>Bienvenido a TraiFlix!</h3>
        </div>

        <br />

        <div className="row">

          <div className="col">
            <form onSubmit={() => this.handleSubmit()}>
              <label>Nombre de usuario:</label>
              <input
                type="username"
                className="form-control"
                id="usuarioInput"
                placeholder="Escribe el nombre de usuario aquí"
                onChange={event => this.handleChange(event)}
              />
              <br />
              <br />
              <button id="btnlogin" type="button" className="btn btn-primary" onClick={() => this.handleSubmit()}>Ingresar</button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}
