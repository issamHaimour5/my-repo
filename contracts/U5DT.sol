// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

/**
 * @dev Interface for the optional metadata functions from the ERC-20 standard.
 */
interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

/**
 * @dev Provides information about the current execution context.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

/**
 * @dev Standard ERC-20 Errors (ERC-6093)
 */
interface IERC20Errors {
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
    error ERC20InvalidSender(address sender);
    error ERC20InvalidReceiver(address receiver);
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);
    error ERC20InvalidApprover(address approver);
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Implementation of the {IERC20} interface.
 * Based on OpenZeppelin Contracts v5.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual returns (string memory) { return _name; }
    function symbol() public view virtual returns (string memory) { return _symbol; }
    function decimals() public view virtual returns (uint8) { return 6; }
    function totalSupply() public view virtual returns (uint256) { return _totalSupply; }
    function balanceOf(address account) public view virtual returns (uint256) { return _balances[account]; }

    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) revert ERC20InvalidSender(address(0));
        if (to == address(0)) revert ERC20InvalidReceiver(address(0));
        _update(from, to, value);
    }

    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) revert ERC20InsufficientBalance(from, fromBalance, value);
            unchecked { _balances[from] = fromBalance - value; }
        }
        if (to == address(0)) {
            unchecked { _totalSupply -= value; }
        } else {
            unchecked { _balances[to] += value; }
        }
        emit Transfer(from, to, value);
    }

    function _mint(address account, uint256 value) internal {
        if (account == address(0)) revert ERC20InvalidReceiver(address(0));
        _update(address(0), account, value);
    }

    function _burn(address account, uint256 value) internal {
        if (account == address(0)) revert ERC20InvalidSender(address(0));
        _update(account, address(0), value);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) revert ERC20InvalidApprover(address(0));
        if (spender == address(0)) revert ERC20InvalidSpender(address(0));
        _allowances[owner][spender] = value;
        if (emitEvent) emit Approval(owner, spender, value);
    }

    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance < type(uint256).max) {
            if (currentAllowance < value) revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            unchecked { _approve(owner, spender, currentAllowance - value, false); }
        }
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism.
 * Based on OpenZeppelin Contracts v5.
 */
abstract contract Ownable is Context {
    address private _owner;
    error OwnableUnauthorizedAccount(address account);
    error OwnableInvalidOwner(address owner);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(address initialOwner) {
        if (initialOwner == address(0)) revert OwnableInvalidOwner(address(0));
        _transferOwnership(initialOwner);
    }

    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    function owner() public view virtual returns (address) { return _owner; }

    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) revert OwnableUnauthorizedAccount(_msgSender());
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) revert OwnableInvalidOwner(address(0));
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract U5DT is ERC20, Ownable {

    // ─── Custom Errors (gas-efficient, replaces require strings) ────────
    error ContractPaused();
    error AccountRestricted(address account);

    // ─── State ──────────────────────────────────────────────────────────
    mapping(address => bool) private _restricted;
    bool public paused;

    // ─── Events ─────────────────────────────────────────────────────────
    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);
    event AccountRestrictionUpdated(address indexed account, bool restricted);
    event Paused(address indexed account);
    event Unpaused(address indexed account);

    // ─── Constructor ────────────────────────────────────────────────────
    /**
     * @dev Mints the initial supply to the deployer.
     *      Initial Supply: 10,000,000,000,000 tokens (10 Trillion)
     *      Decimals: 6
     */
    constructor() ERC20("U5DT", "U5DT") Ownable(msg.sender) {
        _mint(msg.sender, 10_000_000_000_000 * 10**6);
    }

    // ─── Transfer Hook (override) ───────────────────────────────────────
    /**
     * @dev Adds pause and restriction checks to all transfers.
     *      Skips restriction check on `from` when minting (from == address(0))
     *      to avoid a wasted SLOAD.
     *      Owner can still mint while paused (pause only blocks user transfers).
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        // Allow minting even when paused; block all other transfers
        if (from != address(0)) {
            if (paused) revert ContractPaused();
            if (_restricted[from]) revert AccountRestricted(from);
        }
        // Always check recipient restriction (except burn to address(0))
        if (to != address(0)) {
            if (_restricted[to]) revert AccountRestricted(to);
        }
        super._update(from, to, value);
    }

    // ─── Admin Functions (transparent names) ────────────────────────────

    /**
     * @notice Mints new tokens to `account`.
     * @param account The recipient address.
     * @param amount  The amount of tokens to mint (in smallest unit).
     */
    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
        emit TokensMinted(account, amount);
    }

    /**
     * @notice Burns tokens from `account`.
     * @param account The address to burn from.
     * @param amount  The amount of tokens to burn (in smallest unit).
     */
    function burn(address account, uint256 amount) external onlyOwner {
        _burn(account, amount);
        emit TokensBurned(account, amount);
    }

    /**
     * @notice Updates the restriction status of an account.
     * @param account    The target address.
     * @param restricted True to restrict, false to unrestrict.
     */
    function setRestriction(address account, bool restricted) external onlyOwner {
        _restricted[account] = restricted;
        emit AccountRestrictionUpdated(account, restricted);
    }

    /**
     * @notice Checks if an account is restricted.
     * @param account The address to check.
     * @return True if the account is restricted.
     */
    function isRestricted(address account) external view returns (bool) {
        return _restricted[account];
    }

    /**
     * @notice Pauses or unpauses all user transfers.
     * @dev Minting by owner is still allowed when paused.
     * @param _paused True to pause, false to unpause.
     */
    function setPaused(bool _paused) external onlyOwner {
        paused = _paused;
        if (_paused) {
            emit Paused(_msgSender());
        } else {
            emit Unpaused(_msgSender());
        }
    }
}
