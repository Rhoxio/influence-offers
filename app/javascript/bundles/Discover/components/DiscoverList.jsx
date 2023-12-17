import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import { DiscoverContext } from './DiscoverContext'
import DiscoverForm from './DiscoverForm'
import Offer from "./Offer"
import ErrorDisplay from "./ErrorDisplay"

const DiscoverList = ({renderForm}) => {
  const offersData = useContext(DiscoverContext)
  const offers = offersData.offers

  const [activeOffers, setActiveOffers] = useState(offers)
  const [error, setError] = useState("")

  return(
    <>
    <ErrorDisplay error={error} setError={setError}/>
    <div className="discover-container">
      <h3 className="discover-title">Discover <span className="orange-text">Offers</span></h3>
      { offersData.renderForm && 
        <DiscoverForm setError={setError} setActiveOffers={setActiveOffers}/>
      }
      <div className="offers-list">
        { 
          activeOffers.length > 0 && activeOffers.map((collection, index) => (
            <Offer 
              setError={setError} 
              show={collection.show} 
              offer={collection.offer} 
              tags={collection.tags} 
              suggestionMetrics={{...collection.contribution, total_weight: collection.weight, title: collection.offer.title}} 
              key={`offer-${collection.offer.id}`}
            />
          ))          
        }
        {
          activeOffers.length === 0 && 
          <p className="no-offers">It looks like no offers are available!</p>
        }
      </div>
    </div>
    </>
  )
}

export default DiscoverList;

