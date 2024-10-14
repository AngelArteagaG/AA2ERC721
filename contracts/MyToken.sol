// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/access/Ownable.sol";


contract GymMiembroNFT is ERC721, Ownable {
    uint256 public nextTokenId; 
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("GymMiembroNFT", "GYMM") {}

     function NuevaMembresia(address to, string memory metadataURI) external onlyOwner {
        uint256 tokenId = nextTokenId;
        nextTokenId++; // Incrementa el ID para la siguiente acuñación

        _safeMint(to, tokenId); // Acuña el NFT
        _setTokenURI(tokenId, tokenURI); // Asigna la URI (metadatos) del token
    }
     // Función para asociar una URI a un token
    function _setTokenURI(uint256 tokenId, string memory metadataURI) internal {
        _tokenURIs[tokenId] = tokenURI;
    }
    // Función para obtener la URI de un token en específico
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token no existe");
        return _tokenURIs[tokenId];
    }
     // Función para que el propietario del NFT lo use en el gimnasio (simulando el uso del NFT)
    function CanjeMembresia(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "No eres miembro");
        // Aquí puedes agregar lógica para registrar el uso de la membresía
        // o incluso quemar el token si es de un solo uso.
        // Ejemplo:
        // _burn(tokenId); // Si quieres que el NFT se queme al ser usado.
    }
}
