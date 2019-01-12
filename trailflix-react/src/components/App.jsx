import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import 'open-iconic/font/css/open-iconic-bootstrap.min.css';
import '../dist/css/App.css';

import React from 'react';
import { Switch, Route } from 'react-router';
import { BrowserRouter } from 'react-router-dom';

import AppLogin from './AppLogin';
import Home from './Home.jsx';
import Serie from './Serie.jsx';
import Pelicula from './Pelicula.jsx';
import Search from './Search.jsx';
import Capitulo from './Capitulo.jsx';
import Filtered from './Filtered';

export default class App extends React.Component {
  componentDidMount() {
    document.title = 'TraiFlix';
  }

  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route path="/content/movies" component={Filtered} />
          <Route path="/content/series" component={Filtered} />
          <Route path="/content/:category" component={Filtered} />
          <Route path="/search/:text" component={Search} />
          <Route path="/home/:auth/movie/:id" component={Pelicula} />
          <Route path="/home/:auth/serie/:serie" component={Serie} />
          <Route path="/home/:auth/cap/:cap" component={Capitulo} />
          <Route path="/home/:auth" component={Home} />
          <Route path="/home" component={Home} />
          <Route path="/" component={AppLogin} />
        </Switch>
      </BrowserRouter>
    );
  }
}
