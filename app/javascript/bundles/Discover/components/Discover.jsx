import PropTypes from 'prop-types';
import React, { useState, useContext, createContext } from 'react';
import DiscoverForm from './DiscoverForm'
import DiscoverList from './DiscoverList'
import { DiscoverContext } from './DiscoverContext'

const Discover = (props) => {
  return(
    <div className="discover-container">
      <DiscoverContext.Provider value={props.offers}>
        <h3 className="discover-title">Discover Offers</h3>
        <DiscoverForm tags={props.tags}/>
        <DiscoverList/>
      </DiscoverContext.Provider>
    </div>
  )
}

export default Discover;