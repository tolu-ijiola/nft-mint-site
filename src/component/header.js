const Header = (props) => {
    return(
        <header>
            <a>Nft Mint</a>
            {props.account === "" ? <button onClick={props.connectWallet}>Connect wallet</button> : <button className="log-out-btn"><p className="account">{props.account}</p>...<i class="fas fa-sign-out-alt"></i></button>}
        </header>
    )
}

export default Header