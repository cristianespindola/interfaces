import '../dist/css/Serie.css';
import { Link } from 'react-router-dom';
import React from 'react';
import API from './Api';


export default class Serie extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      username: props.match.params.auth,
      codigo: props.match.params.serie,
      serie: '',
      capitulos: [],
      contenrel: [],
      contenfav: [],
      visto: '',
      amigos: [],
      err: '',
    };
  }

  componentDidMount() {
    API.get(`/${this.state.username}/serie/${this.state.codigo}`)
      .then(response => this.setState({
        serie: response,
        capitulos: response.capitulos,
        contenrel: response.contenidoRelacionado,
      }))
      .catch(error => this.setState({ err: error }));
    API.get(`/${this.state.username}/favs`)
      .then(response => this.setState({
        contenfav: response,
      }))
      .catch(error => this.setState({ err: error }));
    API.get(`/${this.state.username}/vio/serie/${this.state.codigo}`)
      .then(response => this.setState({
        visto: response.visto.startsWith('t'),
      }))
      .catch(error => this.setState({ err: error }));
    API.get(`/${this.state.username}/amigos`)  
      .then(response => this.setState({ amigos: response }))
      .catch(error => this.setState({ err: error }));
  }

  agregarContenidoALista(cont) {
    const url = `/home/${this.state.username}/${cont.type}/${cont.id}`;
    return (
      <Link to={url} className="list-group-item" key={cont.id}>{cont.titulo} ({cont.type}).</Link>
    );
  }

  agregarEpisodioALista(cap) {
    const url = `/home/${this.state.username}/cap/${cap.id}`;
    return (
      <Link to={{ pathname: url, state: { ...this.state.capitulos.find(ep => ep.id === cap.id) } }}
            className="list-group-item"
            key={cap.linkYT}>T{cap.nroTemporada} C{cap.nroCapitulo} - {cap.titulo}.
      </Link>
    );
  }

  estrella(cant) {
    let res = [];
    if (cant < 1) {
      res = 'Sin valorización.';
    } else {
      for (let i = 0; i < cant; i += 1) {
        res.push(<span className="oi oi-star" key={i} />);
      }
    }
    return res;
  }

  favButtonText() {
    let res = '';
    if (this.state.contenfav.filter(elem => elem.id === this.state.serie.id).length === 1) {
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
    const contFav = this.state.contenfav.filter(elem => elem.id === this.state.serie.id);
    if (contFav.length === 0) {
      const serie = { ...this.state.serie };
      const conta = this.state.contenfav;
      const contn = conta;
      contn.push(serie);
      API.put(`/${this.state.username}/fav/serie/${this.state.serie.id}`, { value: true })
        .then(this.setState({ contenfav: contn }))
        .catch(error => this.setState({ err: error }));
    } else {
      const contfavp = this.state.contenfav;
      const contfavn = contfavp.filter(elem => elem.id !== this.state.serie.id);
      API.put(`/${this.state.username}/fav/serie/${this.state.serie.id}`, { value: false })
        .then(this.setState({ contenfav: contfavn }))
        .catch(error => this.setState({ err: error }));
    }
  }

  handleWatch() {
    if (!this.state.visto) {
      API.put(`/${this.state.username}/watched/serie/${this.state.serie.id}`, { value: true })
        .then(this.setState({ visto: true }))
        .catch(error => this.setState({ err: error }));
    } else {
      API.put(`/${this.state.username}/watched/serie/${this.state.serie.id}`, { value: false })
        .then(this.setState({ visto: false }))
        .catch(error => this.setState({ err: error }));
    }
  }

  infoContenRel() {
    if (this.state.contenrel.length > 0) {
      return (
          <ul className="list-group">
            <li className="list-group-item active">CONTENIDO RELACIONADO</li>
            {this.state.contenrel.map(cont => this.agregarContenidoALista(cont))}
          </ul>);
    }
  }

  infoEpisodios() {
    return (
      <ul className="list-group">
        <li className="list-group-item active">CAPITULOS DE LA SERIE</li>
        {this.state.capitulos.map(cap => this.agregarEpisodioALista(cap))}
      </ul>);
  }

  infoserie() {
    return (
      <ul className="list-group">
        <li className="list-group-item active">INFO DE LA SERIE</li>
        <li className="list-group-item">Clasificación: {this.state.serie.clasificacion}.</li>
        <li className="list-group-item">Categorías: {this.state.serie.categoria}.</li>
        <li className="list-group-item">Creadores: {this.state.serie.creadores}.</li>
        <li className="list-group-item">Rating: {this.estrella(this.state.serie.rating)}</li>
      </ul>);
  }

  recomendarA(amigo) {
    API.post(`/recommend/serie/${this.state.serie.id}`, { userfrom: this.state.username, userto: amigo, })
      .catch(error => this.setState({ err: error }));
  }

  amigosARecomendar(amigo) {
    return (
      <a className="dropdown-item" key={amigo} onClick={() => this.recomendarA(amigo)}>{amigo}</a>
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
      <div className="container" id="containerSerie">
        {this.handleError()}
        <div className="p-3 mb-2 bg-info text-white" id="headerSerie">
          <h2>TraiFlix Series - {this.state.serie.titulo}</h2>
          <div className="topright"> <span className="oi oi-person" /> {this.state.username}</div>
        </div>
        <br />

        <div className="row">
          <div className="col-md-8" id="panelIzq">

            <div id="videoDiv">
              <iframe
                width="100%"
                height="400"
                src={this.state.serie.link.toString()}
                frameBorder="0"
                allow="encrypted-media"
                allowFullScreen
                title="vidtitle"
              />
            </div>
            <br />
            {this.infoEpisodios()}
            <br />
            {this.infoContenRel()}
            <br />
            <button type="button" className="btn btn-primary btnSerie" onClick={() => this.handleFav()}>{this.favButtonText()} Favoritos</button>
            <br />
            <br />
            <button type="button" className="btn btn-primary btnSerie" onClick={() => this.handleWatch()}>Marcar como {this.watchButtonText()}</button>
            <br />
            <br />
            <button type="button" className="btn btn-danger btnSerie dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Recomendar</button>
            <div className="dropdown-menu">
              {this.recomendar()}
            </div>
            <br />
            <br />
            <br />
            <div className="btn-group-vertical">
              <button type="button" className="btn oi oi-arrow-circle-left" onClick={() => this.props.history.goBack()} />
              <button type="button" className="btn-lg oi oi-home" onClick={() => this.props.history.push(`/home/${this.state.username}`)} />
            </div>
          </div>

          <div className="col-md-4">
            <div>{this.infoserie()}</div>
            <br />
          </div>
          
        </div>
      </div>
    );
  }
}
