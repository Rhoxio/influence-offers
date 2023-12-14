import PropTypes from 'prop-types';
import React, { useState } from 'react';
import DiscoverForm from './DiscoverForm'
import DiscoverList from './DiscoverList'

const Discover = (props) => {
  // console.log(props)
  return(
    <div className="discover-container">
      <h1>Discover Component</h1>
      <DiscoverForm tags={props.tags}/>
      <DiscoverList offers={props.offers}/>
    </div>
  )
}

export default Discover;