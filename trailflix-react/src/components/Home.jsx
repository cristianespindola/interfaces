import '../dist/css/home.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import 'open-iconic/font/css/open-iconic-bootstrap.min.css';
import { Link } from 'react-router-dom';
import React from 'react';
import API from './Api';
import Header from './Header.jsx';

export default class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: props.match.params.auth,
      favs: [],
      categs: [],
      watched: [],
      recommended: [],
      mostRec: [],
      showAllRecommended: false,
    };
  }

  componentDidMount() {
    API.get(`/${this.state.name}/favs`)
      .then(response => this.setState({ favs: response }))
      .catch(error => this.setState({ err: error }));
    API.get('/categories')
      .then(responseCatgs => this.setState({ categs: responseCatgs }));
    API.get(`/${this.state.name}/watched/movies`)
      .then(responseWatched => this.setState({ watched: responseWatched }));
    API.get(`/${this.state.name}/mostrecommended`)
      .then(responseMostR => this.setState({ mostRec: responseMostR }));
    API.get(`/${this.state.name}/recommended`)
      .then(responseRec => this.setState({ recommended: responseRec }));
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

  createFavsContent() { // metodo q esta en render()
    return (this.createTitleAndContent([<span className="oi oi-heart" key="fav" />, ' Favoritos'], this.state.favs));
  }

  createTitleAndContent(title, contentList) {
    if (contentList.length === 0) {
      return [];
    }
    const contenido = this.contentToCards(contentList);
    return (
      <div id="containerMaterial">
        <h4 className="alert alert-primary" id="mainTitle">{title}</h4>
        {contenido}
      </div>
    );
  }

  contentToCards(contentList) {
    return contentList.map((cont, i) => <div className="list-inline-item" key={`card_${i}`}> {this.createCard(cont)}</div>);
  }

  splitElementsOn(listToSplit, number) {
    // Retorna un array de arrays con 'number' elementos
    const numberOfRows = Math.ceil((listToSplit ? listToSplit.length : 0) / number);
    const splited = [];
    for (let i = 0; i < numberOfRows; i += 1) {
      splited.push(listToSplit.slice(i * number, number * (i + 1)));
    }
    return splited;
  }

  createCard(contenido) {
    return (
      <div className="card-columns3" key={contenido.id}>
        <img className="card-img" src={contenido.portada} alt="portada" id="imagecard" />
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

  createSideBar() {
    const categoriesBtns = [];
    this.state.categs.map((catg, i) => (
      categoriesBtns.push(
        <li key={i}>
          <Link
            to={{ pathname: `/content/${catg.toLowerCase()}`, state: { name: this.state.name, categs: this.state.categs } }}
            onClick={() => window.location.reload()}
            id="subtitle"
          >
            {catg}
          </Link>
        </li>,
      )
    ));
    return (
      <div className="float-left" id="sideBar">
        <ul id="sideBarList">
          <li>
            <Link
              id="subtitle"
              to={{ pathname: '/content/movies', state: { name: this.state.name, categs: this.state.categs } }}
              onClick={() => window.location.reload()}
            >
             Películas
            </Link>
          </li>
          <li>
            <Link
              id="subtitle"
              to={{ pathname: '/content/series', state: { name: this.state.name, categs: this.state.categs } }}
              onClick={() => window.location.reload()}
            >
             Series
            </Link>
          </li>
          <li>
            <button
              type="button"
              className="navbar-brand btn btn-link"
              id="subtitle"
            >
            Categorias
            </button>
          </li>
          {categoriesBtns}
        </ul>
      </div>
    );
  }

  render() {
    return (
      <React.Fragment>
        {this.handleError()}
        <Header name={this.state.name} {...this.props} />
        {this.createSideBar()}
        <div className="container" id="containerMaterial">
          {this.createFavsContent()}
          {this.createTitleAndContent('Más recomendadas ', this.state.mostRec)}
          <button type="button" className="navbar-brand btn btn-link" id="link" onClick={() => this.setState({ showAllRecommended: true })}>
            Ver todas las recomendaciones
          </button>
          {this.state.showAllRecommended ? this.createTitleAndContent('Todas las recomendadas', this.state.recommended) : ''}
          {this.createTitleAndContent('Volvé a mirarlas', this.state.watched)}
        </div>
      </React.Fragment>
    );
  }
}
