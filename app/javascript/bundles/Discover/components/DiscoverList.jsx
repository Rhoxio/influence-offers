import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import { DiscoverContext } from './DiscoverContext'
import Offer from "./Offer"

const DiscoverList = () => {
  const offers = useContext(DiscoverContext)
  console.log(offers)
  return(
    <div className="offers-list">
      {
        offers.map((collection, index) => (
          <Offer offer={collection.offer} tags={collection.tags} key={`offer-${collection.offer.id}`}/>
        ))
      }
    </div>
  )
}

export default DiscoverList;