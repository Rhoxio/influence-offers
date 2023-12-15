import PropTypes from 'prop-types';
import React, { useState, useContext, createContext } from 'react';
import DiscoverList from './DiscoverList'
import { DiscoverContext } from './DiscoverContext'

const Discover = (props) => {
  return(
      <>
      <DiscoverContext.Provider value={props}>
        <DiscoverList/>
      </DiscoverContext.Provider>
      </>
  )
}

export default Discover;