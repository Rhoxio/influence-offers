import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import { DiscoverContext } from './DiscoverContext'
import DiscoverForm from './DiscoverForm'
import Offer from "./Offer"
import ErrorDisplay from "./ErrorDisplay"

const DiscoverList = () => {
  const offersData = useContext(DiscoverContext)
  const offers = offersData.offers
  const [activeOffers, setActiveOffers] = useState(offers)
  const [error, setError] = useState("")

  return(
    <>
    <ErrorDisplay error={error} setError={setError}/>
    <div className="discover-container">
      <h3 className="discover-title">Discover <span className="orange-text">Offers</span></h3>
      <DiscoverForm setActiveOffers={setActiveOffers}/>
      <div className="offers-list">
        {
          activeOffers.map((collection, index) => (
            <Offer showActions={true} setError={setError} show={collection.show} offer={collection.offer} tags={collection.tags} key={`offer-${collection.offer.id}`}/>
          ))
        }
      </div>
    </div>
    </>
  )
}

export default DiscoverList;