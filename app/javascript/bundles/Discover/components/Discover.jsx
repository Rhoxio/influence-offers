import PropTypes from 'prop-types';
import React, { useState, useContext, createContext } from 'react';
import DiscoverList from './DiscoverList'
import { DiscoverContext } from './DiscoverContext'

const Discover = (props) => {
  // console.log(props)
  return(
    <div className="discover-container">
      <DiscoverContext.Provider value={props}>
        <h3 className="discover-title">Discover Offers</h3>
        <DiscoverList/>
      </DiscoverContext.Provider>
    </div>
  )
}

export default Discover;