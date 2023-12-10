import React from "react"
import PropTypes from "prop-types"

const Index = (props) => {
  return (
    <React.Fragment>
      Greeting: {props.greeting}
    </React.Fragment>
  )
}

Index.propTypes = {
  greeting: PropTypes.string
};

export default Index