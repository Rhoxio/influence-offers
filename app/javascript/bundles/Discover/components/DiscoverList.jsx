import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import { DiscoverContext } from './DiscoverContext'
import DiscoverForm from './DiscoverForm'
import Offer from "./Offer"

const DiscoverList = () => {
  const offersData = useContext(DiscoverContext)
  const offers = offersData.offers
  const [activeOffers, setActiveOffers] = useState(offers)

  return(
    <>
    <DiscoverForm setActiveOffers={setActiveOffers}/>
    <div className="offers-list">
      {
        activeOffers.map((collection, index) => (
          <Offer show={collection.show} offer={collection.offer} tags={collection.tags} key={`offer-${collection.offer.id}`}/>
        ))
      }
    </div>
    </>
  )
}

export default DiscoverList;