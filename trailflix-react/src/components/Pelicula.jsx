import '../dist/css/Pelicula.css';
import React from 'react';
import { Link } from 'react-router-dom';
import API from './Api';

export default class Pelicula extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      username: props.match.params.auth,
      id: props.match.params.id,
      pelicula: '',
      contenidos: [],
      amigos: [],
      contenfav: [],
      visto: '',
    };
  }

  componentDidMount() {
    API.get(`/${this.state.username}/movie/${this.state.id}`)
      .then(response => this.setState({ pelicula: response }))
      .catch(error => this.setState({ err: error }));
    API.get(`/${this.state.username}/movie/${this.state.id}`)
      .then(response => this.setState({ contenidos: response.contenidoRelacionado }))
      .catch(error => this.setState({ err: error }));
    API.get(`/${this.state.username}/amigos`)
      .then(response => this.setState({ amigos: response }))
      .catch(error => this.setState({ err: error }));
  }

  pedirAño(fecha) {
    return new Date(fecha).getFullYear();
  }

  agregarContenidoAVista(contenido) {
    return (
      <Link to={`/home/${this.state.username}/${contenido.type}/${contenido.id}`} className="list-group-item"> {contenido.titulo} ({contenido.type})</Link>
    );
  }

  contenidosRelacionados() {
    return (
      <ul className="list-group">
        <li className="list-group-item active">Contenido Relacionado</li>
        {this.state.contenidos.map(contenido => this.agregarContenidoAVista(contenido))}
      </ul>);
  }

  estrella(cant) {
    if (cant === 0) {
      return 'sin valorización';
    }
    const res = [];
    for (let i = 0; i < cant; i += 1) {
      res.push(<span className="oi oi-star" />);
    }
    return res;
  }

  favButtonText() {
    let res = '';
    if (this.state.contenfav.filter(elem => elem.id === this.state.pelicula.id).length === 1) {
      res = 'Quitar de';
    } else {
      res = 'Agregar a';
    }
    return res;
  }

  watchButtonText() {
    let res = '';
    if (this.state.visto) {
      res = 'No Vista';
    } else {
      res = 'Vista';
    }
    return res;
  }

  handleFav() {
    const contFav = this.state.contenfav.filter(elem => elem.id === this.state.pelicula.id);
    if (contFav.length === 0) {
      const pelicula = { ...this.state.pelicula };
      const conta = this.state.contenfav;
      const contn = conta;
      contn.push(pelicula);
      API.put(`/${this.state.username}/fav/movie/${this.state.pelicula.id}`, { value: true })
        .then(this.setState({ contenfav: contn }))
        .catch(error => this.setState({ err: error }));
    } else {
      const contfavp = this.state.contenfav;
      const contfavn = contfavp.filter(elem => elem.id !== this.state.pelicula.id);
      API.put(`/${this.state.username}/fav/serie/${this.state.pelicula.id}`, { value: false })
        .then(this.setState({ contenfav: contfavn }))
        .catch(error => this.setState({ err: error }));
    }
  }

  handleWatch() {
    if (!this.state.visto) {
      API.put(`/${this.state.username}/watched/movie/${this.state.pelicula.id}`, { value: true })
        .then(this.setState({ visto: true }))
        .catch(error => this.setState({ err: error }));
    } else {
      API.put(`/${this.state.username}/watched/movie/${this.state.pelicula.id}`, { value: false })
        .then(this.setState({ visto: false }))
        .catch(error => this.setState({ err: error }));
    }
  }

  recomendarA(amigo) {
    API.post(`/recommend/movie/${this.state.pelicula.id}`, { userfrom: this.state.username, userto: amigo })
      .catch(error => this.setState({ err: error }));
  }

  amigosARecomendar(amigo) {
    return (
      <button type="button" className="dropdown-item" onClick={() => this.recomendarA(amigo)}>{amigo}</button>
    );
  }

  recomendar() {
    return (
      <li className="list-group-item">
        {this.state.amigos.map(amigo => this.amigosARecomendar(amigo))}
      </li>
    );
  }

  handleError() { // appLogin copypaste modified
    let error = '';
    if (this.state.err) {
      const msg = 'Ha ocurrido un error. Código de error: ';
      error = (
        <div className="alert alert-danger alert-dismissible fade show" role="alert">
          {msg}{this.state.err.response.status}. {this.state.err.response.data.message}.
          <button type="button" className="close" data-dismiss="alert" aria-label="Close" onClick={() => this.props.history.push('/')}>
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      );
    }
    return (error);
  }

  render() {
    return (
      <div className="container" id="containerPelicula">
        {this.handleError()}
        <div className="p-3 mb-2 bg-info text-white" id="headerPelicula">
          <h2>TraiFlix Pelicula - {this.state.pelicula.titulo}</h2>
          <div className="topright"> <span className="oi oi-person" /> {this.state.username}</div>
        </div>
        <br />
        <div className="row">
          <div id="videoDiv">
            <iframe
              width="600"
              height="400"
              src={this.state.pelicula.link}
              frameBorder="0"
              allow="encrypted-media"
              allowFullScreen
              title="vidtitle"
            />
          </div>

          <div className="col-md-4" id="panelIzq">
            <ul className="list-group">
              <li className="list-group-item active">INFO DE LA PELICULA</li>
              <li className="list-group-item">Clasificacion: {this.state.pelicula.clasificacion}.</li>
              <li className="list-group-item">Duracion: {this.state.pelicula.duracion}.</li>
              <li className="list-group-item">Categorias: {this.state.pelicula.categoria}.</li>
              <li className="list-group-item">AñoDeEstreno: {this.pedirAño(this.state.pelicula.fechaDeEstreno)}.</li>
              <li className="list-group-item">Directores: {this.state.pelicula.directores}.</li>
              <li className="list-group-item">Ranking: {this.estrella(this.state.pelicula.ranking)}</li>
            </ul>
          </div>
          <div className="col-md-8">
            {this.contenidosRelacionados()}
            <br />
            <div className="col-md-3">
              <button type="button" className="btn btn-primary btnPelicula" onClick={() => this.handleFav()}>{this.favButtonText()} Favoritos</button>
              <br />
              <br />
              <button type="button" className="btn btn-primary btnPelicula" onClick={() => this.handleWatch()}>Marcar como {this.watchButtonText()}</button>
              <br />
              <br />
              <div className="btn-group">
                <button type="button" className="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Recomendar</button>
                <div className="dropdown-menu">
                  {this.recomendar()}
                </div>
              </div>
            </div>
          </div>
        </div>
        <br />
        <div className="btn-group-vertical">
          <button type="button" className="btn oi oi-arrow-circle-left" onClick={() => this.props.history.goBack()} />
          <button type="button" className="btn-lg oi oi-home" onClick={() => this.props.history.push(`/home/${this.state.username}`)} />
        </div>
      </div>
    );
  }
}
