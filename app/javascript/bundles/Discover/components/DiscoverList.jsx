import PropTypes from 'prop-types';
import React, { useState } from 'react';

const DiscoverList = ({offers}) => {
  // console.log(offers)
  return(
    <div className="offers-list">
      {
        offers.map((offer, index) => (
          <h3 className="offer" key={index}>{offer.title}</h3>
        ))
      }
    </div>
  )
}

export default DiscoverList;