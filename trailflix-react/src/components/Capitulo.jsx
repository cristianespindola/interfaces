import '../dist/css/Serie.css';
import React from 'react';


export default class Capitulo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      username: props.match.params.auth,
      titulo: props.location.state.titulo,
      fechaDeEstreno: props.location.state.fechaDeEstreno,
      link: props.location.state.linkYT,
      rating: props.location.state.rating,
      nroTemporada: props.location.state.nroTemporada,
      nroCapitulo: props.location.state.nroCapitulo,
      duracion: props.location.state.duracion,
      dirs: props.location.state.directores,
      acts: props.location.state.actoresPrincipales,
    };
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

  infoepisodio() {
    return (
      <ul className="list-group">
        <li className="list-group-item active">INFO DEL CAPITULO</li>
        <li className="list-group-item">Fecha de Estreno: {this.state.fechaDeEstreno}.</li>
        <li className="list-group-item">Número de Temporada: {this.state.nroTemporada}.</li>
        <li className="list-group-item">Número de Capítulo: {this.state.nroCapitulo}.</li>
        <li className="list-group-item">Duración: {this.state.duracion} minutos.</li>
        <li className="list-group-item">Directores: {this.state.dirs}.</li>
        <li className="list-group-item">Actores Principales: {this.state.acts}.</li>
        <li className="list-group-item">Rating: {this.estrella(this.state.rating)}</li>
      </ul>);
  }


  render() {
    return (
      <div className="container">
        <div className="p-3 mb-2 bg-info text-white" id="headerEpisodio">
          <h2>TraiFlix Capítulo - {this.state.titulo}</h2>
          <div className="topright"> <span className="oi oi-person" /> {this.state.username}</div>
        </div>

        <br />
        <div className="row">
          <div className="col-md-12">
            <div id="videoDivEp">
              <iframe
                width="80%"
                height="500"
                src={this.state.link.toString()}
                frameBorder="0"
                allow="encrypted-media"
                allowFullScreen
                title="vidtitle"
              />
            </div>
            <br />
            <div>{this.infoepisodio()}</div>
            <br />
            <div className="btn-group-vertical">
              <button type="button" className="btn oi oi-arrow-circle-left" onClick={() => this.props.history.goBack()} />
              <button type="button" className="btn-lg oi oi-home" onClick={() => this.props.history.push(`/home/${this.state.username}`)} />
            </div>
          </div>

        </div>
      </div>
    );
  }
}
