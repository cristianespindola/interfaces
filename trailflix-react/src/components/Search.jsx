import '../dist/css/home.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import 'open-iconic/font/css/open-iconic-bootstrap.min.css';
import React from 'react';
import { Link } from 'react-router-dom';
import API from './Api';
import Home from './Home';
import Header from './Header';

export default class extends Home {
  constructor(props) {
    super(props);
    this.state = {
      name: props.location.state.name,
      contenidos: [],
    };
  }

  componentDidMount() {
    this.search(this.props.match.params.text);
  }

  componentWillReceiveProps(nextProps) {
    // Se agrega este mensaje dado que si se quiere realizar una nueva busqueda
    // en la pantalla de search no vuelve a ejecutar el componentDidMount dado que ya esta montado.
    this.search(nextProps.match.params.text);
  }

  search(text) {
    API.post('/search', {
      pattern: text,
    })
      .then(response => this.setState({ contenidos: response }));
  }

  createCard(contenido) {
    return (
      <div className="card mb-3" key={contenido.id}>
        <img className="card-img-top imageCard" src={contenido.portada} alt="portada" />
        <div className="card-body">
          <h5 className="card-title">{contenido.titulo}</h5>
          <div className="card-text">
            <span className="badge">{contenido.type}</span>
          </div>
          <Link to={`/home/${this.state.name}/${contenido.type}/${contenido.id}`}>Ver detalles</Link>
        </div>
      </div>
    );
  }

  createContenidoContent() {
    const contenido = this.contentToCards(this.state.contenidos);
    return (
      <div>
        <h4 id="subtitle"><span className="oi oi-clock" /> Resultado de la busqueda</h4>
        {contenido}
      </div>
    );
  }


  render() {
    return (
      <React.Fragment>
        <Header name={this.state.name} {...this.props} />
        <div className="container" id="containerMaterial">
          {this.createContenidoContent()}
        </div>
        <div className="btn-group-vertical">
          <button type="button" className="btn oi oi-arrow-circle-left" onClick={() => this.props.history.goBack()} />
          <button type="button" className="btn-lg oi oi-home" onClick={() => this.props.history.push(`/home/${this.state.name}`)} />
        </div>
      </React.Fragment>
    );
  }
}
