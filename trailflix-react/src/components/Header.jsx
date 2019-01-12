import { Link } from 'react-router-dom';
import React from 'react';

const logo = require('../dist/logotraiflix.png');

export default class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: props.name,
      toSearch: '',
    };
  }

  handleChange(event) {
    this.setState({ toSearch: event.target.value });
  }

  handleSubmit() {
    this.props.history.push({ pathname: `/search/${this.state.toSearch}`, state: this.state });
  }

  goHome() {
    this.props.history.push(this.home());
  }

  home() {
    return `/home/${this.state.name}`;
  }

  render() {
    return (
      <React.Fragment>
        <nav className="navbar navbar-light bg-light">
          <button type="button" className="navbar-brand btn btn-link" onClick={() => this.goHome()}>
            <img src={logo} alt="TraiFlix" />
          </button>
          <div className="form-row">
            <input
              className="form-control"
              type="search"
              placeholder="Ingresar texto..."
              onChange={event => this.handleChange(event)}
            />
            <button className="btn btn-outline-success my-2 my-sm-0" type="submit" onClick={() => this.handleSubmit()}>Search</button>
          </div>
          <ul className="nav navbar-nav navbar-rigth">
            <li className="nav-item justify-content-center">
              <p className="nav-link"><span className="oi oi-person" /> {this.state.name} </p>
              <Link className="nav-link" to="/">Salir</Link>
            </li>
          </ul>
        </nav>
      </React.Fragment>
    );
  }
}
