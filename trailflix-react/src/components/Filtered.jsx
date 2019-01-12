import '../dist/css/Filtered.css';
import React from 'react';
import API from './Api';
import Home from './Home';
import Header from './Header';

export default class Filtered extends Home {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      category: props.location.pathname.split('/').pop(),
      content: [],
      name: props.location.state.name,
      categs: props.location.state.categs,
    };
  }

  componentDidMount() {
    if (this.state.category === 'movies' || this.state.category === 'series') {
      switch (this.state.category) {
        case 'movies':
          API.get('/content/movies')
            .then(response => this.setState({ content: response }))
            .catch(error => this.setState({ err: error }));
          this.setState({ title: 'Películas' });
          break;
        case 'series':
          API.get('/content/series')
            .then(response => this.setState({ content: response }))
            .catch(error => this.setState({ err: error }));
          this.setState({ title: 'Series' });
          break;
        default:
      }
    } else {
      API.get(`/content/${this.state.category.replace(/[^\w]/gi, '')}`)
        .then(response => this.setState({ content: response }))
        .catch(error => this.setState({ err: error }));
      this.setState({ title: this.props.match.params.category });
    }
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
      <React.Fragment>
        {this.handleError()}
        <Header name={this.state.name} {...this.props} />
        {this.createSideBar()}
        <div className="container" id="containerMaterial">
          <h3 id="title">{this.state.title}</h3>
          {this.contentToCards(this.state.content)}
        </div>
        <div className="btn-group-vertical">
          <button type="button" className="btn oi oi-arrow-circle-left" onClick={() => this.props.history.goBack()} />
          <button type="button" className="btn-lg oi oi-home" onClick={() => this.props.history.push(`/home/${this.state.name}`)} />
        </div>
      </React.Fragment>
    );
  }
}
